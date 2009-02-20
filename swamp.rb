require 'lilypond'
include Lilypond

score = []

r1 = Rhythm.new(*%w(8. 16 8 8))
score << [
  r1[%w(c  d e c)], %w(g'4 r),
  r1[%w(c, d e c)], %w(b4  r),
  r1[%w(c  d e c)], %w(g'4 g16 f e d),
  %w(c8 c16 d16 e8 c16 b d4 r4)
].flatten

score << [
  r1[%w(c d e g)], %w(c4 r4),
  r1[%w(e, f g e)], %w(a4 g16 f e d),
  r1[%w(c d e g)], %w(c4 r4),
  %w(c16 c c c c8 g b g b d)
].flatten

score << [
  r1[%w(c d e c)], %w(a' a,16 g a g a8),
  r1[%w(g a b g)], %w(e' e,16 d e d e8),
  r1[%w(d e f d)], %w(b' a g f),
  r1[%w(e f g b)], %w(e d d c)
 ].flatten

r2 = Rhythm.new(8, 16, 16)
notes = %w(
  c, e g  g b d  c g e   b' g d
  c  e g  a c e  e c a   d b f 
  d' a f  b g d  a' f d  g d b
)
score << r2.apply(notes)

notes = %w(
  r4 c'8. d16 e8 c g c e4 c8 e f4 d4
  r4 c8. d16 e8 c g c e4 c8 e d4 b4
  r4 c8. d16 e8 c e f g4 e8 g a4 f4
  r4 e8. f16 g8 e g c c4 g8 c b4 g4
  c
)
score << notes
puts <<-EOS
\\header {
  title = Bubblegloop Swamp
}

\\relative {
EOS
Formatter.new.format(score)
puts <<-EOS
}

\\version "2.12.2"
EOS
