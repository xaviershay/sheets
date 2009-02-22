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
}
lower = \relative c {
  \time 6/4
  \clef bass

  r1 r2 r1 r2 r1 r2 r1 r2
  c4 e g aes4. g4.~
  g2~ g16 d fis a
  \times 3/4 {
    bes4 a fis d
  }
  c4 aes'4 g e4. c4.
  d4. d' aes fis

  c4 e g aes g e
  d fis a d fis bes
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
