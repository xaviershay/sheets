$s = Process.clock_gettime(Process::CLOCK_MONOTONIC)

$LOAD_PATH.unshift File.expand_path("./src/ruby", File.dirname(__FILE__))

require 'build_plan'
require 'fileutils'

DIGEST_FILE = File.expand_path(".digests.json", File.dirname(__FILE__))

build_plan = BuildPlan.new(digest_file: DIGEST_FILE)
BuildPlan.logger.level = Logger::INFO

LY_FILES = Dir["src/lilypond/*.ly"]

pdf_files = []

build_plan.load do
  directory "www"
  directory "www/static"

  LY_FILES.each do |ly_file|
    name = File.basename(ly_file, ".ly")
    pdf = "www/static/#{name}.pdf"
    pdf_files << pdf
    output_base = "www/static/#{name}"

    deps = ["www/static", ly_file] + Dir["src/lilypond/#{name}/**/*.ly"]

    grouped_file "Lilypond", pdf => deps do
      system("lilypond", "-dno-point-and-click", "-o", output_base, ly_file) or
        raise "lilypond failed for #{ly_file}"
    end
  end

  grouped_file "Index", "www/index.html" => ["www", "src/www/index.html"] do
    FileUtils.cp("src/www/index.html", "www/index.html")
  end

  task "build" => ["www/index.html"] + pdf_files do
  end
end

build_plan.build "build"

build_plan.save_digests!(DIGEST_FILE)
