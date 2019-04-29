alto = \transpose c a \relative c' {
 \Key
 bes8 bes r bes bes bes r bes 
 bes4 bes,2. 
 bes'8 bes r bes bes4 r |
 bes8 bes r bes bes4 r |
 bes8 bes r bes bes bes r bes 
 bes4 bes,2. |

 % A
 \bar "||"
 \repeat unfold 2 {
   r2 r4 r8 bes'8~ |
   bes8 bes~ bes4 d8 f r4 |
   r2 r4 r8 bes,8~ |
   bes8 bes~ bes4 g8 f r4 |
   r2 r4 r8 bes8~ |
   bes8 bes~ bes4 d8 f r8 bes,8~ |
   bes4~ bes8 bes~ bes4~ bes8 bes8~ |
   bes4~ bes8 bes~ bes4 r  |
 }
 \sl d^"Solo" d d d
 d d d d
 d d d d
 d d d d
 d d d d
 d d d d
 d d d d
 d d
 \nsl
 r2

 r2 r4 r8 bes8~ |
 bes8 bes~ bes4 d8 f r4 |
 r2 r4 r8 bes,8~ |
 bes8 bes~ bes4 g8 f r4 |
 r2 r4 r8 bes8~ |
 bes8 bes~ bes4 d8 f r8 bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

 % B
 \bar "||"
  \mark \markup { \musicglyph #"scripts.segno" }
 \repeat unfold 3 {
   des4( bes8) r des4( bes8) r |
   des8 bes r g f4 g |
 }
 des'4( bes8) r des4. bes8~ |
 bes2 r2 |
 \repeat unfold 3 {
   des4( bes8) r des4( bes8) r |
   des8 bes r g f4 g |
 }
 des'4( bes8) r des4. bes8~ |
 bes2 r2 |

 R1*8
 \repeat unfold 3 {
   des4( bes8) r des4( bes8) r |
   des8 bes r g f4 g |
 }
 des'4( bes8) r des2 |
 bes2 r2 |

 % C
 \bar "||"
 \repeat unfold 2 {
   bes8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) r8 |
   bes,8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) r8 |
   bes,8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) bes,8~ |
   bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 }
 \alternative {
   { bes4~ bes8 bes~ bes4 r  | }
   { bes4~ bes8 bes~ bes4 r  | }
 }
 \tiny
 \transpose a d \relative c'' {
  \key bes \major
   d2.^"Solo (Clarinet)" c4
   b a g fis8 f~ |
   f4 f8 g a f e d |
   e f e d g f e d |
   c d e g c4 c |
   c c c8 c r8 f,~\mordent |
   f4 r8 f8~\mordent f4 r8 f8~\mordent |
   f4 r8 f8~\mordent f4 r4 |
 }

 \key bes \major
 \normalsize

 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

 R1*8
 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
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
     \startStaff
   \cadenzaOff
   
   \break
  \once \override Score.RehearsalMark #'extra-offset = #'( -8.42 . 1.75 )
   
 \once \override Score.RehearsalMark #'font-size = #5
 \mark \markup { \musicglyph #"scripts.coda" }

 % Coda
 bes2 r4 bes4~\fermata |
 bes1
 \bar "|."
}
