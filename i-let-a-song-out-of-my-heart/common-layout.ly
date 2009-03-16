#(set-global-staff-size 22.45) 

\header {
  title = "I Let A Song Go Out Of My Heart"
  composer = "Duke Ellington"
  arranger = "Arranged by Xavier Shay"
  piece = \piece
  tagline = \markup { \column { "" } }
}

\score {
  <<
    \context ChordNames {
      \chordsTransposed
    }
    \new Staff = "upper" {
      \melodyTransposed
    }
  >>
  \layout { 
    indent = #0
  }
}
