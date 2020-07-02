\version "2.19.83"
\header {
  title = "Chameleon"
  arranger = "Arranged by Xavier Shay"
  tagline = \markup { \column { "" } }
}

upper = \relative c' {
  \clef "treble"
  \key aes \major
  \time 2/2

  r1 |
  \repeat volta 2 {
  <des f bes>8
  <des f bes>8
  r4
  <c ees aes>8
  <c ees aes>8
  r4 |
  <des f bes>8
  <des f bes>8
  r4
  <e g des'>4.
  <des f bes>8
  |
  r1
  |
  r2
  <e bes'>8
  aes
  f
  <ees aes>8~
  |
  <ees aes>4
  <f bes>8
  r8
  r2
  |
  r2
  r4
  <des g des'>4~
  |
  <des g des'>4
  <ees bes' ees>8
  r8
  r2
  |
  r1
  }
  \repeat volta 2 {
  r4
  <aes c f>4
  <g bes ees>2
  |
  <g bes ees>4
  <f aes des>2
  ees'8 des |
  bes aes f aes~
  aes4
  bes8
  r8
  |
  r2
  <e, bes'>8
  aes
  f
  <ees aes>8~
  |
  <ees aes>4
  <f bes>8
  r8
  r2
  |
  r2
  r4
  <des g des'>4~
  |
  <des g des'>4
  <ees bes' ees>8
  r8
  r2
  |
  r1
  }
  r4
  <aes c f>4
  <g bes ees>2
  |
  <g bes ees>4
  <f aes des>2.~
  |
  <f aes des>1
  |
  \clef "bass"
  r4 g,, aes a | bes r8 aes'8 r4 bes4 |
  \bar "|."
}

lower = \relative c {
  \clef "bass_8"
  \key aes \major
  \time 2/2

  r4 g, aes a | bes r8 aes'8 r4 bes4 |
  r4 c, des d | ees r8 des'8 r4 ees4 |
  r4 g,, aes a | bes r8 aes'8 r4 bes4 |
  r4 c, des d | ees r8 des'8 r4 ees4 |
  r4 g,, aes a | bes r8 aes'8 r4 bes4 |
  r4 c, des d | ees r8 des'8 r4 ees4 |
  r4 g,, aes a | bes r8 aes'8 r4 bes4 |
  r4 c, des d | ees r8 des'8 r4 ees4 |
  r4 g,, aes a | bes

  \ottava #1
  <g'' c f>4
  <f bes ees>2
  |
  <f bes ees>4
  <ees aes des>2.~
  |
  <ees aes des>1
  |
  \ottava #0

  r4 g,, aes a | bes r8 aes'8 r4 bes4 |
}

harmonies = \chordmode {
  \override ChordName #'font-size = #0.5
  r1
  \repeat unfold 4 {
    bes1:min7
    bes1:min7
    ees:9
    ees:9
  }
}

#(set-global-staff-size 18)
\score {
<<
  \context ChordNames {
      \set chordChanges = ##t
      \harmonies
  }
  \new PianoStaff <<
     \set PianoStaff.instrumentName = "Piano  "
     \new Staff = "upper" \upper
     % \new Dynamics = "dynamics" \dynamics
     \new Staff = "lower" \lower
  >>
  >>
  \layout { }
  \midi { }
}
