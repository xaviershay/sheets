\version "2.18.2"

\header {
  % TODO: https://fontmeme.com/fonts/super-mario-extended-font/
  title = "Snow Theme (Night), Super Mario World"
  subtitle = "Super Mario Maker 2"
  arranger = "Transcribed by Xavier Shay"
  tagline = \markup { \column { "LilyPond source at https://xaviershay.com/sheets" } }
}
segno   = \mark \markup { \musicglyph #"scripts.segno" }
dsh   = \mark \markup{ \bold   "D.S."}
upper = \relative c''' {
  \clef treble
  \key f \major
  \time 4/4


  d4 bes8. f16 e8. f16 g4 \bar "||"

  \segno

  a8 a a a bes bes bes bes |
  a8 a a a bes bes4.

  \repeat volta 2 {
    a4 f d16 f8 f16( f4) |
    c8 f f bes a4 g |
    a4 f d16 f8. f4 |
    c8 f bes16 a g8 f2
  }

  a8. f16( f8) c a'8. f16( f4) |
  aes16 g f8 aes8. g16( g2) |
  a8. f16( f8) c a'8. f16( f4) |
  aes16 g f8 c'2.

  a4 f d16 f8 f16( f8.) g16 |
  a f c8 d8. f16( f2) |

  c'4 c8. c16 bes4 a8. g16 |
  f2 r2 |

  \repeat volta 2 {
    f2 d8 f g4 |
    a2 d,2 |
    f2 e2 |
  }
  \alternative {
    { f2 r2 }
    { f2 r2 \bar "||" }
  }
  \dsh
}

lower = \relative c'' {
  \clef "treble^8"
  \key f \major
  \time 4/4

  bes'4 f8. d16 c8. d16 e4 |

  f4 d g c, |
  f d g8 ges4. |

  \repeat volta 2 {
    f4 a bes b
    a g f8 c d e |
    f4 a bes b |
    c8 c, d g f c f4 |
  }

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

  \repeat volta 2 {
    bes,8 a bes b r4 b4 |
    a8 c a g fis a d, fis |
    g8 a bes b c e, c' bes |
  }
  \alternative {
    { a c a e f c f a }
    { a c a e f c f4  }
  }
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

