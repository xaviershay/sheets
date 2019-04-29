\version "2.10.10"

\include "common-notes.ly"

piece = "Trombone"
chordsTransposed = \transpose c c {
  \harmonies
}
melodyTransposed = \transpose c c,, {
  \clef bass
  \melody
}

\include "common-layout.ly"
