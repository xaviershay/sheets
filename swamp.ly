\version "2.12.2"
\header {
  title = "Bubblegloop Swamp"
  arranger = "Xavier Shay"
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

  \bar "||"
  \key ees \major
  c8.  d16  ees8   c    aes'   aes,16 g    aes    g    aes8   
  g8.  aes16  bes8   g    ees'   ees,16 d    ees    d    ees8   
  d8.  ees16  f8   d    bes'   aes    g    f    
  ees8.  f16  g8   bes    ees    ees d    cis    

  c8. aes16 ees8 aes c c ees c
  bes8. aes16 g8 aes bes4 r
  b8. c16 d8 c b g b g
  f4 aes g b

  \bar "||"
  \key c \major
  <<c8 c,>>   e16  g    ges8   bes16  des    c8   g16  e    bes'8  ges16  des    
  c8   e16  g    aes8   c16  ees    e8   c16  aes    d8   bes16  f    
  des'8  aes16  f    b8   g16  d    aes'8  f16  des    g8   d16  bes    

  r4   c'8. d16  e8   c    g    c    
  e4   c8   e    f4   des    
  r    c8.  d16  e8   c    g    c    
  e4   c8   e    d4   bes    
  r    c8.  d16  e8   c    e    f    
  g4   e8   g    aes4   f    
  r    e8.  f16  g8   e    g    c    
  c4   g8   c    bes4   g    
  c r r2

  \bar "||"
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

  \bar "||"

  \key ees \major
  aes, <<aes' c>> r <<aes c>> ees, <<aes c>> r <<aes c>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> r <<g bes>>
  bes, <<f' bes>> r <<f bes>> f, <<f' bes>> r <<f bes>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> a, <<g' a>> 

  aes, <<aes' c>> r <<aes c>> ees, <<aes c>> r <<aes c>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> r <<g bes>>

  g, <<f' b>> r <<f b>> g, <<f' b>> r <<f b>>
  des, <<f aes>> r <<f aes>> aes, <<f' b>> b, <<f' b>> 
 
  \bar "||"

  \key c \major
  c,4 ges c ges
  c aes e' bes
  des g, des' g,

  c,8 <<e' g>> r <<e g>> r <<e g>> g, <<e' g>>
  c,,8 <<e' g>> r <<e g>> des, <<des' f>> des, <<des' f>>
  c,8 <<e' g>> r <<e g>> r <<e g>> g, <<e' g>>
  c,,8 <<e' g>> r <<e g>> bes,, <<d' f>> bes,, <<d' f>>

  c,8 <<e' g>> r <<e g>> r <<e g>> g, <<e' g>>
  c,,8 <<e' g>> r <<e g>> des, <<des' f>> des, <<des' f>>
  c,8 <<e' g>> r <<e g>> r <<e g>> g, <<e' g>>
  c,,8 <<e' g>> r <<e g>> bes,, <<d' f>> bes,, <<d' f>>
  <<c,4 c'>> r r2 
  \bar "||"
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
