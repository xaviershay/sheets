harmonies = \chordmode {
  \transpose c g {
    \set chordChanges = ##t
    \partial 8 s8
    f1:min7 s1 ees ees:7
    aes:7 s1 s s2 

    \set chordChanges = ##f
    ees

    \time 1/16 
    s16 \bar "" 

    \repeat volta 2 {
      \time 4/4 
      ees2
      \set chordChanges = ##t
      aes ees c:min7 c1:7 s aes2 f:min7 ees/g aes
    }
    \alternative {
      { ees c:min7 f:min7 bes:7 | }
      { ees aes:min ees1 | }
    }
    f2:min7 f:min7 bes1:7
    ees2 ees ees aes c:min c:min7
    ges1:9 b:7 bes:9

    % Coda
    bes1:7 ees1
  }
}

melody = \transpose c g, \relative c' {
  \key ees \major
  
  \partial 8 ees'8~\accent^"Intro" |
  ees4 c8 aes f aes c ees |
  r8 c r4 r8 d\accent r d~ |
  d4 bes8 g ees g bes c | 
  des4 bes8 c8 r4 r8 ges'~\accent |
  ges8 ees c r ees4 c8 r |
  ees4 c8 ees r4 r8 ges~\accent |
  ges8 ees c r ees4 c8 r |
  ees4 c8 d ees r r4  |

    \break

    % the hidden measure and bar line 
    \set Score.markFormatter = #format-mark-box-letters 
    \once \override Score.RehearsalMark #'outside-staff-priority = #5000 
    \once \override Score.RehearsalMark #'self-alignment-X = #LEFT 
    \once \override Score.RehearsalMark #'break-align-symbols = #'(bar-line)
    
    \once \override Score.RehearsalMark #'X-offset = #0
    \mark \markup { \musicglyph #"scripts.segno" }
    \once \override Score.TimeSignature #'stencil = ##f 
    \bar "|"
    \time 1/16 
    s16 \bar "|:" 

  \repeat volta 2 {
    \once \override Score.TimeSignature #'stencil = ##f 
    \time 4/4 
    \once \override Score.RehearsalMark #'X-offset = #-1
    \once \override Score.RehearsalMark #'self-alignment-X = #LEFT 
    \once \override Score.RehearsalMark #'break-align-symbols = #'(bar-line)
        
    \mark \default
    ees,8 f ees ees'~ ees4. c8 |
    \times 2/3 { bes c bes } ees,2. |
    r8 d'4. c8 bes g d |
    d'4 g,8 c8~ c2 |
    f,8 g4 aes8~ aes a4 bes8~ |
    bes ees4.~ ees4. 
    c8
    \once \override Score.RehearsalMark #'outside-staff-priority = #1
    \once \override Score.RehearsalMark #'X-offset = #-1
    \mark \markup { \musicglyph #"scripts.coda" }
    |
  }
  \alternative {
    {
      \times 2/3 { bes c bes } ees,2. |
      R1 |
    }
    {
      \times 2/3 { bes'8 c bes } ees,2. |
      r4 bes'4 bes a |
    }
  }
  \bar "||"
  \once \override Score.RehearsalMark #'outside-staff-priority = #1
  \once \override Score.RehearsalMark #'X-offset = #-2
  \mark \default 
  aes1 | 
  r4 c c b |
  bes1 |
  r4 bes c d |
  ees ees ees ees |
  ees des ges, aes | 
  b1 |
  c8 fis,~ 
  \once \override TextScript #'X-offset = #-8
  fis2._\markup { "D.S. al Coda" }
  
  \bar "|."

        \once \override TextScript #'word-space = #1.5
        \once \override TextScript #'X-offset = #8
        \once \override TextScript #'Y-offset = #1.5
        
  \break
  %\once \override Score.RehearsalMark #'extra-offset = #'( -8.42 . 1.75 )
  
   
 \once \override Score.RehearsalMark #'font-size = #3
 \mark \markup { \musicglyph #"scripts.coda" }
  
  \times 2/3 { bes8 c bes } ees,2 f4 |
  ees2 r2

  \bar "|."
}
