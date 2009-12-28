\version "2.13.9"
\header {
  title = "Muppet Show Theme"
  arranger = "Arranged by Xavier Shay"
  tagline = \markup { \column { "" } }
}

upper = \relative c' {
  \clef "treble_8"
  \key c \major
  \time 4/4

  r4 c c a |
  b a8 b r g~ g4 |
  r4 c c a |
  b8 a8 r g~ g2 |
  r4 e e g |
  f e8 f r c'~ c c, |
  <c e>4 <c e>8 <c e>~ <c e> <c e> <b g'>4 |
  R1 |

  r4 c' c a |
  b a8 b r g~ g4 |
  r4 c c a |
  b8 a8 r g~ g2 |
  r4 e e g |
  f e8 f r c'~ c c, |
  <c e>4 <c e>8 <b d>~ <b d> <b d> c4 |
  
  r2 r4 c' | 
  d c b d | 
  c g r c |
  d c b d |
  \override Glissando #'style = #'zigzag
  c2\glissando c'4 c, |
  d c b d |
  e g, r g |
  a a8 b~ b c d4 |
  r4 \acciaccatura fis,16 g4 r4 \clef bass \acciaccatura fis,16 g4 |
  \clef treble

  r4 c'' c a |
  b a8 b r g~ g4 |
  r4 c c a |
  b8 a8 r g~ g2 |
  r4 e e g |
  f e8 f r c'~ c c, |
  e8 e e e8~ e c e4 |
  a8 a a a8~ a e a4 |
  c8 c c c8~ c a c4 |
  e8 e e e8~ e c e4 |
  <c, f a>2 <c f b> |
  <c f a c> <\parenthesize c f a d> |
  <f a e'> <f a e'> |
  <f a e'> <f a e'> |
  \repeat tremolo 4 { <c' e g>16 <g a>  } 
  << {
    \override Glissando #'style = #'zigzag
    g4.\glissando 
    \change Staff = "lower" 
    g,,,8
  } \\ {
    \change Staff = "upper" 
    s4. b'''8\rest
  } >>
  R1
  \bar "|."
  
}

lower = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c <e g> bes <e g> |
  a, <f' a> aes, <f' aes> |
  <a, f' a>8 r8 r8 <aes f' aes> r4 <g f' g> |
  r4 g a b |

  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c <e g> bes <e g> |
  a, <f' a> aes, <f' aes> |
  <g, e' g>8 r8 r8 <g d' f> r4 <g c e> |
  R1 |

  <f' a c>4 r <e gis c> r |
  <e g c> \clef bass g,,4 c, r4 |
  \clef treble
  <f'' a c>4 r <e gis c> r |
  <e g c> r4 r2 |
  <f a c>4 r <e gis c> r |
  <e g c> r4 r2 |
  <f a c>8 r r <fis a c> r4 <g b>4 |
  r2 \acciaccatura fis,16 g4 r |

  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c <e g> bes <e g> |
  a, <f' a> aes, <f' aes> |
  \clef bass
  <g, e' g>8 r r <g e' g>~ <g e' g>2 |
  <fis c' fis>8 r r <fis c' fis>~ <fis c' fis>2 |
  <f a e'>8 r r <f a e'>~ <f a e'>2 |
  <d f d'>8 r r <d f d'>~ <d f d'>2 |
  
  \clef bass

  r4 <d, d'>~ <d d'> <d d'>~ |
  <d d'> <d d'>~ <d d'> <d d'>~ |
  <d d'> <d d'>~ <d d'> <d d'>~ |
  <d d'> <g, g'>~ <g g'> <g g'> |
  \set tieWaitForNote = ##t
  \repeat tremolo 4 { c16~ c'~ } 
  <c, c'>4. s8 |
  
  c,4 r r2  
  \bar "|."


}

#(set-global-staff-size 18)
\score {
  \new PianoStaff <<
     \set PianoStaff.instrumentName = "Piano  "
     \new Staff = "upper" \upper
     \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}

\markup {
  \tiny { % \teeny \tiny \small \normalsize \large \huge
           % are all viable options here, with \normalsize
           % the default. Pick whatever looks good.
    \fill-line { % This centers the words, which looks nicer
      \hspace #1.0 % gives the fill-line something to work with
      \column {
      \hspace #1.0 % gives the fill-line something to work with
        "It's time to play the music. It's time to light the lights. "
        "It's time to meet the Muppets on the Muppet Show tonight. "
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "It's time to put on makeup. It's time to dress up right."
        "It's time to raise the curtain on the Muppet Show tonight."
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "Why do we always come here? I guess we'll never know."
        "It's like a kind of torture, to have to watch the show."
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "And now let's get things started. Why don't you get things started?"
        "It's time to get things started on the most sensational, inspirational,"
        "Celebrational, Muppetational - This is what we call the Muppet Show! "
      }
      \hspace #1.0 % gives the fill-line something to work with
    }
  }
}


