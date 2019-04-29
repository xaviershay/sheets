\version "2.10.10"
\header {
 title = "Big Apple Contest"
 arranger = "Arranged by Solomon Douglas"
 piece = "Alto Sax"
 tagline = \markup {
   \column {
     "Transcribed by Xavier Shay"
     "Creative Commons Attribution License"
     "Melbourne, 16th March 2009"
   }
 }
}

\include "common.ly"
\include "alto.ly"

chordsTransposed = \transpose c a {
  \gtrharmony
}

#(set-global-staff-size 16)
\score {
  <<
    \context ChordNames {
      \chordsTransposed
    }
    \new Staff = "upper" \alto
  >>
  \layout { 
    indent = #0
  }
}
