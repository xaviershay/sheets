\version "2.12.2"
\header {
  title = "Overture"
  arranger = "Xavier Shay"
}

upper = \relative c'' {
  \time 6/4
  \key c \major

  c8 g' e aes
  c, g' e aes
  c, g' e aes

  d, a' fis bes
  d, a' fis bes
  d, a' fis bes

  c,8 g' e aes
  c, g' e aes
  c, g' e aes

  \set tupletSpannerDuration = #(ly:make-moment 3 8) 
  \times 6/5 { 
    d,16 fis gis ais c 
    d c ais gis fis
    d fis gis ais c 
    d c ais gis fis
  }

  c8 g' e aes
  c, g' e aes
  c, g' e aes

  d, a' fis bes
  d, a' fis bes
  d, a' fis bes

  c, g' e aes
  c, g' e aes
  c, g' e aes

  \set tupletSpannerDuration = #(ly:make-moment 3 8) 
  \times 6/5 { 
    d,16 fis gis ais c 
    d c ais gis fis
    d fis gis ais c 
    d c ais gis fis
  }

  c8 g' e aes
  c, g' e aes
  c, g' e aes

  d, a' fis bes
  d, a' fis bes
  d, a' fis bes

  \bar "||"
  \time 12/8

  <<bes,4. d g>>
  <<bes,8 d g>>
  <<bes,8 d g>>
  <<bes,8 d g>>
  <<ces,4. ees aes>>
  <<des,8 ges bes>>
  <<des,8 ges bes>>
  <<des,8 ges bes>>
  \bar "||"

  <<bes,4. d g>>
  r4. r4. r4.

  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  R1*3/2 |

  \bar "||"
  \time 4/4

  c,4 b8 c e4 c~
  c4 b8 c f4 c~
  c4 b8 c g'2~
  g8 f e d c d g,4

  \bar "||"
  \time 3/4
}
lower = \relative c {
  \time 6/4
  \clef bass

  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  R1*3/2 |
  c4 e g aes4. g4.~
  g2~ g16 d fis a
  \times 3/4 {
    bes4 a fis d
  }
  c4 aes'4 g e4. c4.
  d4. d' aes fis

  c4 e g aes g e
  d fis a d fis bes

  \times 12/8
  <<g,,2 g'>>
  <<aes,4. aes'>>
  <<bes,4. bes'>>
  
  \key c \minor
  <<g,4 g'>> ees8 d ees d
  c4 g'8 aes4 g8
  c,4 ees8 d ees d
  c4. g

  c4 ees8 d ees d
  c4 g'8 aes4 g8
  bes4. g4 f8
  d4. g,

  c4 ees8 d ees d
  c4 g'8 aes4 g8
  c,4 ees8 d ees d
  c4. g

  c4 ees8 d ees d
  b4 d8 f4 b,8
  c4. g4 ees'8
  c4. r

  \time 4/4
  R1 R1 R1 R1

  \time 3/4
  c8 d ees b c d
  c8 d ees b c d
  c g' c, aes' c, f 
  g c, ees f c d

  c8 d ees b c d
  c8 d ees b c d
  b d b f' b, aes' 
  b, f' b, aes' b, f' 

  c8 d ees b c d
  c8 d ees b c d
  c g' c, aes' c, f 
  g c, ees f c d

  c8 d ees b c d
  c8 d ees b c d

  % About the 1:30 mark
}

\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = #"Piano  "
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>
  \layout { }
  \midi {
     \context {
       \Score
       tempoWholesPerMinute = #(ly:make-moment 120 4)
     }
   }
}
