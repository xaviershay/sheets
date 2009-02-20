\version "2.12.2"
\header {
  title = "Bubblegloop Swamp"
}

upper = \relative {
  \key c \major
  c8.  d16  e8   c    g'4  r    
  c,8. d16  e8   c    bes4   r    
  c8.  d16  e8   c    g'4  g16  f    e    d    
  c8   c16  d    e8   c16  bes    d4   r    

  c8.  d16  e8   g    c4   r    
  e,8. f16  g8   e    aes4   g16  f    e    d    
  c8.  d16  e8   g    c4   r    
  c16  c    c    c    c8   g    b    g    bes   d    

  \key ees \major
  c8.  d16  ees8   c    aes'   aes,16 g    aes    g    aes8   
  g8.  aes16  bes8   g    ees'   ees,16 d    ees    d    ees8   
  d8.  ees16  f8   d    bes'   aes    g    f    
  ees8.  f16  g8   bes    ees    d    cis    c    

  \key c \major
  c,   e16  g    ges8   bes16  des    c8   g16  e    bes'8  ges16  des    
  c8   e16  g    aes8   c16  ees    e8   c16  aes    d8   bes16  f    
  des'8  aes16  f    b8   g16  d    aes'8  f16  des    g8   d16  bes    

  r4   c'8. d16  e8   c    g    c    
  e4   c8   e    f4   d    
  r    c8.  d16  e8   c    g    c    
  e4   c8   e    d4   b    
  r    c8.  d16  e8   c    e    f    
  g4   e8   g    a4   f    
  r    e8.  f16  g8   e    g    c    
  c4   g8   c    b4   g    
  c    
}
lower = \relative c {
  \clef bass

  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> cis, <<cis f>> g, <<cis f>>
  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> bes, <<d f>> g, <<d' f>>

  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> cis, <<cis f>> g, <<cis f>>
  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> bes, <<d f>> g, <<d' f>>
}

\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = #"Piano  "
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}
