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
end
r = Rhythm.new(8, 16, 16)
notes = %w(
  c, e g  g b d  c g e   b' g d
  c  e g  a c e  e c a   d b f 
  d' a f  b g d  a' f d  g d b
)

class Lilypond
  def initialize(options = {})
    @options = options
  end

  def format(notes)
    elapsed = 0
    current_duration = 4
    notes.flatten.each do |note|
      note_pitch    = note[/^[a-z',]+/, 0]
      note_duration = (note[/\d+$/, 0] || current_duration).to_i
      print "%-4s" % [[
        note_pitch,
        note_duration != current_duration ? note_duration : nil
      ].compact.join]
      current_duration = note_duration if note_duration
      elapsed += 4 / note_duration.to_f
      if elapsed >= 4
        puts 
        elapsed = 0
      end
    end
    puts
  end
end
Lilypond.new.format(r.apply(notes))
