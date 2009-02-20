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

score = []

r1 = Rhythm.new(*%w(8. 16 8 8))
score << r1[%w(c d e c)] + %w(g'4 r4) + 
r1[%w(c, d e c)] + %w(b4 r4) 
notes = %w(
  c8. d16 e8 c g'4 r4
  c,8. d16 e8 c b4 r4
  c8. d16 e8 c g'4 g16 f e d
  c8 c16 d16 e8 c16 b d4 r4
)
#score << r1.apply(notes)

r2 = Rhythm.new(8, 16, 16)
notes = %w(
  c, e g  g b d  c g e   b' g d
  c  e g  a c e  e c a   d b f 
  d' a f  b g d  a' f d  g d b
)
score << r2.apply(notes)

class Lilypond
  def initialize(options = {})
    @options = options
  end

  def format(notes)
    elapsed = 0
    current_duration = '4'
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
    puts
  end
end
Lilypond.new.format(score)
