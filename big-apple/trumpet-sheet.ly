\version "2.10.10"
\header {
 title = "Big Apple Contest"
 arranger = "Arranged by Solomon Douglas"
 piece = "Trumpet"
 tagline = \markup {
   \column {
     "Transcribed by Xavier Shay"
     "Creative Commons Attribution License"
     "Melbourne, 16th March 2009"
   }
 }
}

\include "common.ly"
\include "trumpet.ly"

chordsTransposed = \transpose c d {
  \gtrharmony
}

#(set-global-staff-size 16)
\score {
  <<
    \context ChordNames {
      \chordsTransposed
    }
    \new Staff = "upper" \trpt
  >>
  \layout { 
    indent = #0
  }
}
