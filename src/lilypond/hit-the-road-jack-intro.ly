\version "2.19.83"

\header {
  tagline = ""
}
upper = \relative c' {
  \clef treble
  \key f \minor
  \time 2/2

  \partial 8 r8 |
  a8~ <a f'>8~ <a f'>2 bes8~ <bes f'>8~ | <bes f'>1 |
  aes8~ <aes f'>8~ <aes f'>2 bes8~ <bes f'>8~ | <bes f'>2 bes8~ <bes f'>4. |
}

lower = \relative c {
  \clef bass
  \key f \minor
  \time 2/2

  \partial 8 f8~ |
  <f f,>2~ <f f,>4~ <f aes,>4~ | <f aes,>1 |
  <des des,>2~ <des des,>4 <ees ees,>4~ | <ees ees,>1 |

}

\score {
  \new PianoStaff <<
     \set PianoStaff.instrumentName = ""
     \new Staff = "upper" \upper
     \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}

