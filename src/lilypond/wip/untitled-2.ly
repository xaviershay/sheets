\version "2.13.9"
\header {
  title = "Untitled"
  subtitle = ""
  arranger = "Xavier Shay"
  tagline = \markup { \column { "" } }
}
upper = \relative c'' {
  \clef treble
  \key a \minor
  \time 13/8
  #(set-time-signature 13 8 '(4 4 2 3))

  a8 g <d a> <d a>
  a'8 g <e a,> <e a,>
  a8 g <c, a>4. |
  a'8 g <d a> <d a>
  a'8 g <e a,> <e a,>
  a8 g <c, a>4. |

  \time 2/4
  a'8 g <d a> <d a> |

  #(set-time-signature 20 16 '(3 3 3 3 3 3 2))
  <d a e>8.

  e16 a b
  e a b
  e fis e
  b a e
  b a e
  r8  |

  r8.
  e16 a b
  e a b
  e fis e
  b a e
  b a e
  r8  |
}

lower = \relative c {
  \clef bass
  \key a \minor
  #(set-time-signature 13 8 '(4 4 2 3))

  d2 a8 c d2~
  d16 f e g f a |
  d,2 a8 c d2~
  d16 f e g f a |
  \time 2/4
  d,2 |

  #(set-time-signature 20 16 '(3 3 3 3 3 3 2))
  e16 a b
  r8.
  r
  r
  r
  r
  b16 a |
  <e e,>16 a b
  r8.
  r
  r
  r
  r
  b16 a |
}

\score {
  \new PianoStaff <<
     \set PianoStaff.instrumentName = "Piano  "
     \new Staff = "upper" \upper
     \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}
