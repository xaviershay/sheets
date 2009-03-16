harmonies = \chordmode {
  \transpose c g {
  \repeat volta 2 {
    ees2 aes ees c:min7 c1:7 s aes2 f:min7 ees/g aes
  }
  \alternative {
    { ees c:min7 c:min7 bes:7 | }
    { ees aes:min ees1 | }
  }
  f2:min7 f:min7 bes1:7
  ees2 ees:maj7 ees aes c:min c:min7
  ges1:9 b:7 bes:9

  ees2 aes ees c:min7 c1:7 s aes2 f:min7 ees/g aes ees 
  s4 bes:7 ees2 bes:7
  }
}

melody = \transpose c g, \relative c' {
  \key ees \major

  \repeat volta 2 {
    ees8 f ees ees'~ ees4. c8 |
    \times 2/3 { bes c bes } ees,2. |
    r8 d'4. c8 bes g d |
    d'4 g,8 c8~ c2 |
    f,8 g4 aes8~ aes a4 bes8~ |
    bes ees4.~ ees4. c8 |
  }
  \alternative {
    {
      \times 2/3 { bes c bes } ees,2. |
      R1 |
    }
    {
      \times 2/3 { bes'8 c bes } ees,2. |
      r4 bes'4 bes a |
    }
  }
  \bar "||"
  aes1 | 
  r4 c c b |
  bes1 |
  r4 bes c d |
  ees ees ees ees |
  ees des ges, aes | 
  b1 |
  c8 fis,~ fis2. |
  
  \bar "||"

  ees8 f ees ees'~ ees4. c8 |
  \times 2/3 { bes c bes } ees,2. |
  r8 d'4. c8 bes g d |
  d'4 g,8 c8~ c2 |
  f,8 g4 aes8~ aes a4 bes8~ |
  bes ees4.~ ees4. c8 |

  \times 2/3 { bes c bes } ees,2 f4 |
  ees2 r2

  \bar "|."
}
