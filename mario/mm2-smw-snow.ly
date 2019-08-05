\version "2.13.9"
\header {
  title = "Super Mario Maker 2 - SMW Snow Night Theme"
  arranger = "Transcribed by Xavier Shay"
  tagline = \markup { \column { "" } }
}
upper = \relative c''' {
  \clef treble
  \key f \major
  \time 4/4

  a8 a a a bes bes bes bes |
  a8 a a a bes bes4. \bar ".|:"

  a4 f d16 f8 f16( f4) |
  c8 f f bes a4 g |
  a4 f d16 f8. f4 |
  c8 f bes16 a g8 f2 \bar ":|."

  a8. f16( f8) c a'8. f16( f4) |
  aes16 g f8 aes8. g16( g2) |
  a8. f16( f8) c a'8. f16( f4) |
  aes16 g f8 c'2. \bar "||"

  a4 f d16 f8 f16( f8.) g16 |
  a f c8 d8. f16( f2) |

  c'4 c8. c16 bes4 a8. g16 |
  f2 r2 |
}

lower = \relative c' {
  \clef treble
  \key f \major
  \time 4/4

  f4 d g c |
  f, d g8 ges4. |

  f4 a bes b
  a g f8 c d e |
  f4 a bes b |
  c8 c, d g f c f4 |

  bes,8 b c d
  c a f a |
  aes b d f
  g f e c |
  bes a bes d
  f e c a |
  b d f b
  bes d c e |
  f4 f ees es |
  d d des des |
  c r4 r4 d8 e |
  f4 c f f |

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

