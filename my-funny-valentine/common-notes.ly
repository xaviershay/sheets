harmonies = \chordmode {
  \override ChordName #'font-size = #0.3
  \transpose c g' {
    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a

    aes1 f:min7 f2:min6 g:7 f:min g:7

    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a

    aes1 f:min7 aes:min bes:7

    ees2 bes4:sus bes:7
    ees2 bes4:sus bes:7
    ees2 bes4:sus bes:7
    ees2 bes4:sus bes:7
    g2:maj7 g4:7+5 g:7
    c1:min aes2:maj7 aes:6 aes:7 g:7

    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a
    aes1 d2:7-5 g:7 c1:min ees:7
    aes2 aes:maj7 f:min7 bes:7
    ees1 s
  }

}

melody = \transpose c g' {
  \relative c {
  \key c \minor
  c2 d4 ees d4. ees8 d2 
  c2 d4 ees d4. ees8 d2 
  c2 d4 ees bes'2 aes4 g
  f1~ f1 |

  ees2 f4 g f4. g8 f2
  ees2 f4 g f4. g8 f2
  ees2 f4 g d'4. c8 bes4. a8
  aes1~ aes2 g4 f |
  
  \bar "||"

  bes4 r8 ees,8 ees4 d
  ees2 ees4 d |
  c' r8 ees,8 ees4 d 
  ees2 ees4 d d' r8 ees,8 ees4 d |
  ees2 f4 g c1~ c2 d, |

  \bar "||"

  c2 d4 ees d4. ees8 d2 
  ees2 f4 g f4. g8 f2
  c'2 d4 ees d4. ees8 d2
  ees1~ ees1 | 
  ees,2 f4 g f4. g8 f2
  ees1~ ees
  \bar "|."
  }
}
