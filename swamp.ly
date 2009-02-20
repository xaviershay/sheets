\version "2.12.2"
\header {
  title = "Bubblegloop Swamp"
  arranger = "Xavier Shay"
}

upper = \relative {
  \key c \major
  R1 R R R

  c8.  d16  e8\staccato   c\staccato    g'4  r    
  c,8. d16  e8\staccato   c\staccato    des4   r    
  c8.  d16  e8\staccato   c\staccato    g'4  g16  f    e    d    
  c8   c16  d    e8   c16  bes    d4   r    

  c8.  d16  e8\staccato   g\staccato    c4   r    
  e,8. f16  g8\staccato   e\staccato    aes4   g16  f    e    d    
  c8.  d16  e8\staccato   g\staccato    c4   r    
  c16-4  c-3    c-2    c-1    c8-4(   g-1)    bes(    g    b   d)    

  \bar "||"
  \key ees \major
  c8.  d16  ees8\staccato   c\staccato    aes'-5   aes,16-2( g    aes    g    aes8)
  g8.  aes16  bes8\staccato   g\staccato    ees'-5   ees,16-2( d    ees    d    ees8)   
  d8.  ees16  f8\staccato   d\staccato    bes'-5(   aes-3    g-2    f-1)    
  ees8.-2  f16-1  g8-2\staccato   bes-3\staccato    ees-5    ees-5( d-4    cis-3)    

  c8.-4 aes16-2 ees8-1\staccato aes-2\staccato c-4 c( d c)
  bes8. aes16 g8\staccato aes\staccato bes4 r
  b8.-3 c16 d8\staccato c\staccato b-3( g-1) b-4( g-2)
  f4-1 aes g b

  \bar "||"
  \key c \major
  <<c8-5 c,-1>>   e16-2  g-3    ges8-1   bes16-3  des-5    c8-4   g16-2  e-1    bes'8-5  ges16-4  des-2    
  c8-1   e16-2  g-3    aes8-1   c16-2  ees-4    e8-5   c16-3  aes-1    d8-5   bes16-3  f-1    
  des'8-4  aes16-2  f-1    b8-5   g16-3  d-1    aes'8-4  f16-2  des-1    g8-5   d16-3  bes-1    

  \bar "||"
  c4-2   c'8. d16  e8\staccato   c\staccato    g-1\staccato    c-2\staccato    
  e4-4   c8\staccato   e\staccato    f4-5   des-2    
  c4    c8.  d16  e8\staccato c\staccato    g-1\staccato    c-3\staccato    
  e4-5   c8-3\staccato   e-5\staccato    d4-4   bes-2    
  r    c8.-1 d16  e8\staccato   c\staccato    e-2\staccato    f-3\staccato    
  g4-4   e8-1\staccato   g-3\staccato    aes4-4   f-2    
  e4    e8.  f16  g8\staccato   e\staccato    g-2\staccato    c-5\staccato    
  c4   g8\staccato   c\staccato    bes4   g    
  <<c c,>> r r2

  \bar "|."
}
lower = \relative c {
  \clef bass
  c4 r r g
  c4 r bes g

  c8 <<e g>> r4 r g,8 <<e' g>>
  c,8 <<e g>> r4  bes,8 <<d f>> g, <<d' f>>

  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> des <<des f>> g, <<des' f>>
  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> bes, <<d f>> g, <<d' f>>

  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> des <<des f>> g, <<des' f>>
  c8 <<e g>> r <<e g>> r <<e g>> g,8 <<e' g>>
  c,8 <<e g>> r <<e g>> bes, <<d f>> g, <<d' f>> 

  \key ees \major
  aes, <<aes' c>> r <<aes c>> ees, <<aes c>> r <<aes c>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> r <<g bes>>
  bes, <<f' bes>> r <<f bes>> f, <<f' bes>> r <<f bes>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> a, <<g' a>> 

  aes, <<aes' c>> r <<aes c>> ees, <<aes c>> r <<aes c>>
  ees, <<g bes>> r <<g bes>> bes, <<g' bes>> r <<g bes>>

  g, <<f' b>> r <<f b>> g, <<f' b>> r <<f b>>
  des, <<f aes>> r <<f aes>> aes, <<f' b>> b, <<f' b>> 
 
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
