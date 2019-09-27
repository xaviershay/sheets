\version "2.19.83"

\paper {
   #(define fonts
     (set-global-fonts
     #:sans "Super Mario Maker Extended"
   ))
}

\header {
  % TODO: https://fontmeme.com/fonts/super-mario-extended-font/
  title = \markup {
    \override #'(font-family . sans)
    "SMW Night Snow Theme"
  }
  subtitle = \markup {
    \override #'(font-family . sans)
    "Super Mario Maker 2"
  }
  arranger = "Transcribed by Xavier Shay"
  tagline = \markup { \column {
    \override #'(font-family . typewriter)
    "https://xaviershay.com/sheets"
  } }
}
segno   = \mark \markup { \musicglyph #"scripts.segno" }
dsh   = \mark \markup{ \bold   "D.S."}
upper = \relative c''' {
  \clef treble
  \key f \major
  \time 4/4
  \tempo 4 = 132

  d4 bes8. f16 e8 f16 g16~ g4 \bar "||"

  \segno

  a8 a a a bes bes bes bes |
  a8 a a a bes bes4.

  \repeat volta 2 {
    a4 f d16 f8 f16( f4) |
    c8 f f c a4 g |
    a4 f d16 f8 f16( f4) |
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

lower = \relative c' {
  \clef treble
  \key f \major
  \time 4/4

  bes'4-1 f8.-2 d16-3 c8-4 d16 e16~ e4 |

  f4 d g c, |
  f d g8 ges4. |

  \repeat volta 2 {
    f4 a bes b
    a aes g8 c d e |
    f4 a bes b |
    c8 c, e g f c f4 |
  }

  bes,8-4 b c d
  c a f a |
  aes-4 b-3 d-2 f-1
  g-2 f-1 e-2 c-3 |
  bes a bes d
  f e c a-5 |
  b-4 d-3 f-2 b-1
  bes d c e |

  f4 \parenthesize f ees es |
  d \parenthesize d des des |
  c r4 r4 d,8 e |
  f4 c f f |

  \repeat volta 2 {
    bes8 a bes b r4 b4 |
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

