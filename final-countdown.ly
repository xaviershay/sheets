\version "2.18.2"

\header {
  title = "Song for Maya #1"
}

upper = \relative {
  \tempo "con dignità"
  \key fis \minor
  
  r4 r8 cis''16( b cis4 fis,4)
  r4 r8 d'16( cis d8-. cis-. b4) 
  r4 r8 cis16( b cis4 fis,4)
  r4 r8 b16( a b8-. a-. gis-. b-.
  a4.) gis16( a b4.) a16( b
  cis8-. b-. a-. gis-. fis4) d'
  cis2. cis16( d cis b
  cis2.) fis,8 fis
  a4 gis gis fis~ fis1 \bar "|."
}
lower = \relative {
  \clef bass
  \key fis \minor
  fis,1 d b e
  fis2 gis2 a1
  cis~ cis2.
  fis,8 fis
  a4 gis gis fis~
  fis1 \bar "|."
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
