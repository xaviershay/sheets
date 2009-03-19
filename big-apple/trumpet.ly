% ------ Trumpet ------
trpt = \transpose c d \relative c'' {
 \Key
  \set Score.skipBars = ##t

  \tempo 4 = 208
  bes8 bes r bes bes bes r bes 
  bes4 bes,2. 
  bes'8 bes r bes bes4 r |
  bes8 bes r bes bes4 r |
  bes8 bes r bes bes bes r bes 
  bes4 bes,~ bes8 bes'~ bes bes~ 
  \bar "||"

  % A
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes4 r4 |

  R1*7
  r2 r8 bes~ bes bes~ |

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes4 r4 |

  \bar "||"

  % B
  \mark \markup { \musicglyph #"scripts.segno" }
  \repeat unfold 3 {
    r2 bes4 -. r4 |
    r4 r8 bes8 -. r2 |
    r8 bes8 -. r4 r2 |
    bes4 -. r4 r4 bes -. |
  }
  r2 bes4 -. r4 |
  r4 r8 bes8 -. r2 |
  r8 bes8 -. r4 r2 |
  bes4 -. r4 r2 |

  \sl
  a4^"Solo" a a a
  a a a a
  a a a a
  a a a a
  a a a a
  a a a a
  a a a a
  a a a a
  \nsl

  \repeat unfold 1 {
    r2 bes4 -. r4 |
    r4 r8 bes8 -. r2 |
    r8 bes8 -. r4 r2 |
    bes4 -. r4 r4 bes -. |
  }
  r2 bes4 -. r4 |
  r4 r8 bes8 -. r2 |
  r8 bes8 -. r4 r2 |
  \once \override Score.RehearsalMark #'font-size = #4
  \mark \markup { \musicglyph #"scripts.coda" }
  
  bes4 -. r4 r2 |

  \bar "||"

  % C
  \repeat unfold 2 {
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) r8
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) r8
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) bes8~ |
    bes4~ bes8 bes~ bes4~ bes8 bes8~ |
    bes4~ bes8 bes~ bes4 r  |
  }

  R1*8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |

  \tiny
  a8^"Solo" fis g a~ a2 |
  r8 fis g a~ a2 |
  f8 d e f~ f d e f~ |
  f2 r |
  e'8 d c bes a g f ees |
  d c bes a \times 2/3 { d ees d } c4 |
  r4 r8 bes' des bes des bes |
  des4. bes8~ bes4 r4 |
  \normalsize

  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) r8 |
  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) r8 |
  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |
  \bar "||"

  \cadenzaOn 
  \stopStaff
     \once \override TextScript #'word-space = #1.5
        \once \override TextScript #'X-offset = #8
        \once \override TextScript #'Y-offset = #1.5
        | s1*0^\markup { \center-column { "D.S. al Coda" \line { \musicglyph #"scripts.coda" \musicglyph #"scripts.tenuto" \musicglyph #"scripts.coda"} } }
        
        % Increasing the unfold counter will expand the staff-free space
        \repeat unfold 4 {
          s4 s4 s4 s4
          \bar ""
        }
        % Resume bar count and show staff lines again
     \startStaff
   \cadenzaOff
  
  \break
  \once \override Score.RehearsalMark #'extra-offset = #'( -8.42 . 1.75 )
   
 \once \override Score.RehearsalMark #'font-size = #5
 \mark \markup { \musicglyph #"scripts.coda" }
 bes8 -. r r bes -. r4 bes4~\fermata |
 bes1
 \bar "|."
}
