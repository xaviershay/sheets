\header {
  title = "My Funny Valentine"
  subtitle = "Down a 4th from original key"
  arranger = "Arranged by Xavier Shay"
  piece = \piece
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
