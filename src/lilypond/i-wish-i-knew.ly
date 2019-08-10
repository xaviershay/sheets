\version "2.10.10"
\header {
  title = "I Wish I Knew How It Would Feel To Be Free"
  composer = "Billy Taylor"
  tagline = \markup { \column { "" } }
}

harmonies = \chordmode {
  \override ChordName #'font-size = #0.5
  \partial 2 r2 |
  f a:7/e d:min f:9 |
  bes bes/c f bes/c |
  f bes f c/e |
  c/g g:7 c:7 bes/c |
  f a:7/e d:min f:9 |
  bes bes/c f b:dim7 |
  f/c cis:dim7 d:min b:dim7 |
  f/c bes/c f
}

melody = \relative c' {
  \key f \major
  \partial 2 f4 f4 | 
  c'2 a8 g4 f8~ |
  f4 r8 c d4 f |
  f4 c8 c d8 f4 f8~ |
  f4 r f f |
  c'2 d8 c4 a8~ |
  a2 g4 a4 |
  g2 e8 d4 c8~ |
  c2 f4 f4 |
  c'2 a8 g4 f8~ |
  f4 r8 c d4 f |
  f4 c8 c d8 f4 f8~ |
  f4. d8 f f4 a8~ |
  a2 g8 g4 f8~ |
  f2 d8 d4 c8~ |
  c2 d8 f4 f8~  |
  f2
  \bar "|."
}

\score {
  <<
    \context ChordNames {
        \set chordChanges = ##t
        \harmonies
    }
    \new Staff = "upper" {
      \melody
    }
  >>
  \layout { 
    indent = #0
  }
}

