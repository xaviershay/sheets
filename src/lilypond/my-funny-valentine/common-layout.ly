#(set-global-staff-size 22.45) 

\header {
  title = "My Funny Valentine"
  composer = "Richard Rogers"
  arranger = "Arranged by Xavier Shay"
  piece = \piece
  tagline = \markup { \column { "" } }
}

\score {
  <<
    \context ChordNames {
      \set chordChanges = ##t
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
