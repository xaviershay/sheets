require 'set'
require 'digest/md5'
require 'logger'
require 'fileutils'
require 'json'

class BuildPlan
  module Target
    class Base
      attr_reader :target, :deps
      attr_accessor :dep_changed
      attr_accessor :group

      def initialize(target, deps = [])
        @target = target
        @deps = deps
        @dep_changed = false
        @group = nil
      end

      def changed?(_)
        true
      end

      def current_digest
        nil
      end
    end

    class Directory < Base
      def run(digests)
        if Dir.exist?(target)
          false
        else
          FileUtils.mkdir_p(target)
          true
        end
      end
    end

    class Synthetic < Base
      def initialize(target, deps, &block)
        super(target, deps)
        @block = block
      end

      def run(digests)
        @block.call
        true
      end
    end

    class IntermediaryFile < Base
      def initialize(target, deps, &block)
        super(target, deps)
        @block = block
      end

      def run(digests)
        old_digest = current_digest
        @block.call
        new_digest = Digest::MD5.hexdigest(File.read(@target)) rescue nil
        @current_digest = new_digest
        old_digest != new_digest
      end

      def current_digest
        if !defined?(@current_digest)
          @current_digest = Digest::MD5.hexdigest(File.read(target)) rescue nil
        end
        @current_digest
      end

      def changed?(digests)
        !current_digest || current_digest != digests[target]
      end
    end

    class SourceFile < Base
      attr_reader :target

      def initialize(target)
        super(target, [])
      end

      def run(digests)
        if current_digest.nil?
          raise "source file does not exist: #{target}"
        else
          current_digest != digests[target]
        end
      end

      def current_digest
        if !defined?(@current_digest)
          @current_digest = Digest::MD5.hexdigest(File.read(target)) rescue nil
        end
        @current_digest
      end
    end
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def initialize(digest_file: nil)
    @digests = if digest_file
       begin
         JSON.parse(File.read(digest_file))
       rescue Errno::ENOENT
         {}
       end
    else
      {}
    end
    @tasks = {}
  end

  def register_file(path, digest)
    digests[path] = digest
  end

  def load(&block)
    instance_exec(&block)
  end

  def logger
    self.class.logger
  end

  def inspect
    "<BuildPlan: #{tasks.length} targets>"
  end

  def build(*targets)
    group_stats = Hash.new {|h, k| h[k] = Array.new }

    forward = Hash.new {|h, k| h[k] = Set.new }
    backward = Hash.new {|h, k| h[k] = Set.new }


    f = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    prebuild_time = (f - $s) * 1000

    s = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    walk = ->(target, parent) do
      task = tasks.fetch(target)
      forward[target] ||= Set.new
      task.deps.each do |dep|
        walk.(dep, task)
        forward[target] << dep
      end

      backward[target] << parent.target if parent
    end

    targets.each do |target|
      walk.(target, nil)
    end

    seeds = forward.select {|k, v| v.empty? }.keys
    f = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    tree_time = (f - s) * 1000

    while seeds.any?
      logger.debug ""
      logger.debug { "Available: #{seeds}" }
      seed = seeds.shift
      t = tasks[seed]

      notify = backward[seed]

      changed = if t.dep_changed || t.changed?(digests)
        s = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        ret = t.run(digests)
        f = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        if t.group
          group_stats[t.group] << f - s
        else
          #group_stats["Misc"] << f - s
          group_stats[t.target] << f - s
          if t.is_a?(Target::IntermediaryFile)
            logger.debug "Building #{seed}"
          end
        end
        ret
      else
        false
      end
      logger.debug { "#{seed} changed: #{changed}. notifying parents: #{notify.to_a}" }
      notify.each do |parent, _|
        parent_task = tasks[parent]
        parent_task.dep_changed ||= changed
        x = forward[parent]
        x.delete(seed)
        logger.debug { "  Dependencies remaining: #{x.inspect}" }
        dep_changed = parent_task.dep_changed
        parent_changed = parent_task.changed?(digests)

        if x.empty?
          seeds << parent
        end
      end
      backward.delete(seed)
    end

    if group_stats.any?
      indent = [group_stats.keys.map(&:length).max, "Walking Tree".length].max
      total = 0
      group_stats.keys.sort.each do |k|
        runs = group_stats.fetch(k)
        sum = runs.sum * 1000
        total += sum
        puts "%#{indent}s: #{runs.count} in %0.0fms (%0.0fms avg)" % [
          k,
          sum,
          sum / runs.count
        ]
      end
      f = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      overhead = (f - $s) * 1000 - total - prebuild_time - tree_time
      puts
      puts "%#{indent}s: %0.0fms" % ["Prebuild", prebuild_time]
      puts "%#{indent}s: %0.0fms" % ["Walking Tree", tree_time]
      puts "%#{indent}s: %0.0fms" % ["Tasks", total]
      puts "%#{indent}s: %0.0fms" % ["Overhead", overhead]
      puts
      puts "%#{indent}s: %0.0fms" %
        ["Total", prebuild_time + tree_time + total + overhead]
    end
  end

  def grouped_file(group, opts, &block)
    t = file(opts, &block)
    t.group = group
    t
  end

  def file(opts, &block)
    target, deps = *opts.first
    deps = [*deps]
    deps.each do |dep|
      # Generate default source file targets if target hasn't been defined
      # yet.  Defining it explicitly later on will override this default.
      task = Target::SourceFile.new(dep)
      task.group = "Sources"
      tasks[task.target] ||= task
    end
    task = Target::IntermediaryFile.new(target, deps, &block)
    tasks[task.target] = task
  end

  def directory(target)
    task = Target::Directory.new(target)
    task.group = "Directories"
    tasks[task.target] = task
  end

  def task(opts, &block)
    opts.each do |target, deps|
      deps = [*deps]
      deps.each do |dep|
        # Generate default source file targets if target hasn't been defined
        # yet.  Defining it explicitly later on will override this default.
        task = Target::SourceFile.new(dep)
        task.group = "Sources"
        tasks[task.target] ||= task
      end
      task = Target::Synthetic.new(target, deps, &block)
      task.group = "Synthetics"
      tasks[task.target] = task
    end
  end

  def save_digests!(file)
    new_digests = {}
    tasks.each do |_, task|
      if d = task.current_digest
        new_digests[task.target] = d
      end
    end

    File.write(file, JSON.pretty_generate(new_digests))
  end

  attr_reader :digests, :tasks
end
