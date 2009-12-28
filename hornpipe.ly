\version "2.13.9"
\header {
  title = "Bach Before The Mast - Part 2"
  subtitle = "As played by Keith Emerson"
  arranger = "Typeset by Xavier Shay"
  tagline = \markup { \column { "" } }
}
upper = \relative c''' {
  \clef treble
  \key bes \major
  \time 4/4

  r4 r8 bes16 a bes8 bes,8 bes4~ |
  bes8 g'8~ g8 f16 ees d f c f bes,-2 d c bes |
  a16 c-4 d bes a c bes g-2 a-1 c-2 f-4 e-3 f-4 a-5 g e |
  f8-3 g-1 a bes c f,16 a bes4 |
  r16 bes a c,-1 bes-2 a' g bes,-2 a-1 c g' f g, bes f' e |
  f ees d f ees d c ees d c ees c d bes c a |
  bes8 bes, bes f'16-3 ees d f bes-4 a-3 bes-4 c-1 d ees | 
  f8 ees~ ees d16 c d-4 bes ees c bes d a c |
  bes-2 d-1 g-4 fis-3 g-1 bes-4 a-3 f-2 g8-1 a bes cis |
  d8 ees, c' d, r16 bes' c, a' bes, g' a, fis' |
  g8 g, g16 aes' g f ees d c bes c d ees c |
  f8 f, f16 g' f ees d-2 f-5 a,-1 c-3 bes-2 d-1 bes' aes |
  g16 bes d,-1 f-3 ees g b,-1 d-3 c ees g bes, a c f ees |
  g,16 bes a c bes-3 d-5 c-1 ees d fis g bes, a g' a, f' |

  g16 d c bes ees c bes a d bes c a bes4 |
  c16 bes a g a ees c ees a ees d8 d e16 fis |
  g16 f ees d ees d c bes c bes a g g fis e d |
  g''='' f ees d ees d c bes c bes a g g fis e d |
  r8 aes'' g f ees cis d bes |
  c a bes fis g16 bes a c bes g' d fis |
  e8 aes g f ees16 d c bes c d ees c |
  f8 g f ees d16 \prall c bes a bes c bes aes |
  g f' ees g, f ees' d f, ees d' c ees, d c' bes aes |
  g aes g f ees d c bes a bes a g f8 bes'16 a |
  bes8 bes, bes f'16 ees d f bes a bes8 f'16 f |
  ees f' d c d, f c' bes c, ees bes' a bes8 bes,16 a |
  bes8 bes, bes f'16 ees d f bes a bes8 d16 c |
  bes c a' g a, c g' f g, bes f' e f8 g16 a |
  bes8 aes r16 c bes aes g8 f r16 aes g f |
  ees16 g f ees d f ees d ees d c bes bes a g f |
}

lower = \relative c {
  \clef bass
  \key bes \major
  \time 4/4

  r2 r8 bes16-5 d-3 c-4 ees-2 d-3 f-1 |
  ees-4 g-2 f-3 a-1 g-4 bes-2 a-3 c-1 bes a g8 f-1 e |
  f8 bes, c f16 e f8 f, f c'16 bes |
  a16 c f e f a g f e g f ees d e f d |
  e8 f~ f e f a, bes c |
  d8 f,16 a g bes a c bes8 ees, f f, |
  bes4. bes'16-3 a bes8 d16-1 c d8 bes-2 |
  a16 c f, a g bes a c bes8 c d-4 g16-1 fis |
  g8 g, g d'16-2 c bes d g-1 fis-4 g-3 bes-1 a g |
  fis a g bes-1 e, g-1 f a g8 c, d d, |
  g16-5 bes a c bes d g, bes c8 c, c8 c'16-1 bes-3 |
  a16-5 c-4 f a g-4 bes-2 a-3 c-1 bes-3 d-1 c-4 ees-2 d-1 bes c d |
  ees-3 d-4 ees f g f ees d ees c-5 d-4 ees-3 f-1 ees d c |
  bes d c ees d f ees c d-1 c bes g d'8 d, |

  g8 g, g d'16 c bes d g fis g bes a g |
  a8 a, a a'16 g fis a fis ees d8 c16 bes |
  a8 bes c d ees c d4 |
  ees16 g a bes c bes c d ees8 c d4 |
  g16 f ees d ees d c bes c bes a g g f ees d |
  ees g fis a g bes a c bes d c ees d8 d, |
  g8 g16 bes a c bes d c8 d ees16 d c bes |
  a16 c f, a g bes a c bes8 c d bes |
  ees8 d a bes g a bes16 aes g f |

  ees16 f ees d c d ees bes a8 f f'16 ees d c |
  bes4. f'16 ees d f bes a bes c d ees |
  \clef treble f8 a bes f ees a bes bes,16 a \clef bass |
  bes8 bes, bes f'16 ees d f bes a bes g f bes |
  c8 ees f a,16 bes c8 c, f f'16 ees |
  d16 f bes, d c ees d f ees g g, b a c bes d |
  c bes a c bes8 d, ees e f ees16 d |
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

