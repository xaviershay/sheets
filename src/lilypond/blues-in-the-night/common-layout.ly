#(set-global-staff-size 22.45) 

\header {
  title = "Blues In The Night"
  composer = "Mercer & Arlen"
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
