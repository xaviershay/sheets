\version "2.24.4"

\header {
  title = "MAKE THINGS EASIER"
  composer = "Moron Police"
  arranger = "Transcribed by Xavier Shay"
  tagline = \markup { \column { "" } }
}

\score {
  <<
    \new Staff {
        \tempo 4 = 96
        \new Voice = "intro" {
            \relative c'' {
                a4 d, e d b d e d8 e |
                fes4 d b d8 b g4 d' e a, |
                a'4 d, e d b d e d8 e |
                fis8 g fes d b4 d8 b g4 d' e a,|
                \bar "||"

            }
        }
        \new Voice = "lead" {
            \relative c'' {
                %% Verse 1

                a4~ a8. a16 a8. g16 fis8 g |
                a d,~ d4 b8 d e fis~ |
                fis g fis e~ e d~ d a~ |
                a2 r4. a8 |

                d4. cis16 d e4. d8 |
                fis e d g8~ g fis e d |
                r4 d d d |
                fis8 g fis e~ e2 |

                a4~ a8. a16 a8. g16 fis8 g |
                a d,~ d4 b8 d e fis~ |
                fis g fis e~ e d~ d a~ |
                a2 r4. a8 |

                d4. cis16 d e4. d8 |
                fis e d g8~ g fis e d |
                r4 d d d8 d |
                fis8 g fis e~ e4 r8 d8 |
                \bar "||"

                %% Chorus
                b'4. a8 a cis~ cis d~ |
                d fis, e d~ d b d e~ |
                e fis~ fis d~ d4 r8 d8 |
                b'4. a8 a cis~ cis d~ |
                d fis, e d~ d b d e~ |
                e fis~ fis d~ d4 r4 |
                r2 r8 b8 d d~ |
                d bes~ bes bes~ bes a8 g4~ |
                r1 |
                \bar "||"

                %% Verse 2
                a'4. a8 a g fis g |
                a d,~ d8 d b d e fis~ |
                fis g fis e~ e d~ d a~ |
                a2 r4. a8 |

                d4. cis16 d e4. d16 e |
                fis8 e d g8~ g fis e d |
                r4 d d d |
                fis8 g fis e~ e4. d8 |
                \bar "||"

                %% Chorus
                b'4. a8 a cis~ cis d~ |
                d fis, e d~ d b d e~ |
                e fis~ fis4~ fis4. d8~ | d2.~ r8 d8 |

                b'4. a8 a cis~ cis d~ |
                d fis, e d~ d b d e~ |
                e fis~ fis4~ fis4. d8~ | d2~ d8 b d d~ |
                d bes~ bes bes~ bes a8 g4~ |
                \bar "||"
            }
        }
    }
    \new Lyrics \lyricsto "lead" {
      All the things that I re -- mem -- ber
      ta -- king me far from this time and space.
      I knew as a boy that part of me lived in that place
      I could not help it at all.

      Some would call me a pre -- ten -- der
      I was a strange lit -- tle boy I know.
      Naive, I was proud, I had some -- thing to keep for my -- self
      that set me a -- part from the crowd.

      And hide your -- self a -- way from the truth
      Well, I know you'll do.

      And hide your -- self from all that you are, it could take you far.
      It could make things ea -- si -- er.

      Now, I watch you as you stum -- ble.
      The peo -- ple of Rome did -- n't know they'd fall.

      Back then as a child I would sim -- ply ex -- plain to my -- self
      they did not know you at all.

      And hide your -- self a -- way from the truth
      Well, I know you'll do.

      And hide your -- self from all that you are, it could take you far.
      It could make things ea -- si -- er.
    }
>>

  \layout {}
  \midi {}
}
