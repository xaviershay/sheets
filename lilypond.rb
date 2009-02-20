module Lilypond
  class Rhythm
    def initialize(*pattern)
      @pattern = *pattern
    end

    def apply(notes)
      notes = notes.dup
      result = []
      while !notes.empty?
        run = notes.slice!(0, @pattern.length)
        result << run.zip(@pattern).collect {|x| x.join }
      end
      result
    end

    def [](notes)
      apply(notes)
    end
  end

  class Formatter
    def initialize(options = {})
      @options = options
    end

    def format(notes)
      elapsed = 0
      current_duration = '4'
      print_block = lambda do |notes|
        notes.flatten.each do |note|
          note_pitch    = note[/^[a-z',]+/, 0]
          note_duration = (note[/\d+\.?$/, 0] || current_duration)
          print "%-5s" % [[
            note_pitch,
            note_duration != current_duration ? note_duration : nil
          ].compact.join]
          current_duration = note_duration if note_duration
          a = current_duration[/^\d+/, 0].to_i
          b = current_duration[/\.$/, 0]
          elapsed += 4 / a.to_f + (b ? 4 / (a * 2).to_f : 0)
          if elapsed >= 4
            puts 
            elapsed = 0
          end
        end
      end
      notes.each do |block|
        print_block[block]
        puts
      end
      puts
    end
  end
end
