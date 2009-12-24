\version "2.13.9"
\header {
  title = "The Sailor's Hornpipe"
  subtitle = "As played by Keith Emerson"
  arranger = "Typeset by Xavier Shay"
  tagline = \markup { \column { "" } }
}
upper = \relative c''' {
  \clef treble
  \key bes \major
  \time 4/4

  r4 r8 bes16 a bes8 bes,8 bes4~ |
  bes8 g'8~ g8 f16 ees d f c f bes, d c bes |
  a16 c d bes a c bes g a c f e f a g e |
  f8 g a bes c f,16 a bes4 |
  r16 bes a c, bes a' g bes, a c g' f g, bes f' e |
  f ees d f ees d c ees d c ees c d bes c a |
  bes8 bes, bes f'16 ees d f bes a bes c d ees | 
  f8 ees~ ees d16 c d bes ees c bes d a c |
  bes d g fis g bes a f g8 a bes cis |
  d8 ees, c' d, r16 bes' c, a' bes, g' a, fis' |
  g8 g, g16 aes' g f ees d c bes c d ees c |
  f8 f, f16 g' f ees d f a, c bes d bes' aes |
  g16 bes d, f ees g b, d c ees g bes, a c f ees |
  g,16 bes a c bes d c ees d fis g bes, a g' a, f' |
}

lower = \relative c {
  \clef bass
  \key bes \major
  \time 4/4

  r2 r8 bes16 d c ees d f |
  ees g f a g bes a c bes a g8 f e |
  f8 bes, c f16 e f8 f, f c'16 bes |
  a16 c f e f a g f e g f ees d e f d |
  e8 f~ f e f a, bes c |
  d8 f,16 a g bes a c bes8 ees, f f, |
  bes4. bes'16 a bes8 d16 c d8 bes |
  a16 c f, a g bes a c bes8 c d g16 fis |
  g8 g, g d'16 c bes d g fis g bes a g |
  fis a g bes e, g f a g8 c, d d, |
  g16 bes a c bes d g, bes c8 c, c8 c'16 bes |
  a16 c f a g bes a c bes d c es d bes c d |
  ees d ees f g f ees d ees c d ees f ees d c |
  bes d c ees d f ees c d c bes g d'8 d, |
}

\score {
  \new PianoStaff <<
     \set PianoStaff.instrumentName = "Piano  "
     \new Staff = "upper" \upper
     \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}

