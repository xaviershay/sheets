\version "2.12.2"
\header {
  title = "Bubblegloop Swamp"
  arranger = "Xavier Shay"
}

#(define apply-duration (lambda (note a b c d)
  (make-music
    'NoteEvent 
    'duration 
      (ly:make-duration a b c d) 
    'pitch 
      (ly:music-property (first (ly:music-property note 'elements)) 'pitch))))

motif = #(define-music-function (parser location a b c d) (ly:music? ly:music? ly:music? ly:music?) 
  (make-sequential-music
    (list
      (apply-duration a 3 1 1 1)
      (apply-duration b 4 0 1 1)
      (make-music 'ArticulationEvent 'articulation-type "staccato")
      (apply-duration c 3 0 1 1)
      (make-music 'ArticulationEvent 'articulation-type "staccato")
      (apply-duration d 3 0 1 1))))

upper = \relative {
  \key c \major
  R1 R R R

  \motif c d e c g'4  r    
  \motif c, d e c des4 r    
  \motif c d e c g'4  g16  f    e    d    
  c8   c16  d    e8   c16  bes    d4   r    

  \motif c d e g c4 r
  \motif e, f g e aes4  g16  f    e    d    
  \motif c d e g c4 r
  c16-4  c-3    c-2    c-1    c8-4(   g-1)    bes(    g    b   d)    

  \bar "||"
  \key ees \major
  \motif c d ees c    aes'-5   aes,16-2( g    aes    g    aes8)
  \motif g aes bes g  ees'-5   ees,16-2( d    ees    d    ees8)   
  \motif d ees f d    bes'-5(   aes-3    g-2    f-1)    
  ees8.-2  f16-1  g8-2\staccato   bes-3\staccato    ees-5    ees-5( d-4    cis-3)    

  c8.-4 aes16-2 ees8-1\staccato aes-2\staccato c-4 c( d c)
  bes8. aes16 g8\staccato aes\staccato bes4 r
  b8.-3 c16 d8\staccato c\staccato b-3( g-1) b-4( g-2)
  f4-1 aes g b

  \bar "||"
  \key c \major
  \set tupletSpannerDuration = #(ly:make-moment 1 4) 
  \times 2/3 {
    <<c8-5 c,-1>>   e-2  g-3   ges-1   bes-3  des-5   c-4   g-2  e-1    bes'-5  ges-4  des-2 
    c-1 e-2  g-3 aes-1 c-2 ees-4  e-5   c-3  aes-1   d-5  bes-3  f-1    
    des'-4  aes-2  f-1   b-5   g-3  d-1   aes'-4  f-2  des-1   g-5 d-3  bes-1 
  }

  \bar "||"
  c4-2 \motif c' d e c  g8-1\staccato    c-2\staccato    
  e4-4 c8\staccato   e\staccato    f4-5   des-2    
  c4   \motif c d e c   g8-1\staccato    c-3\staccato    
  e4-5   c8-3\staccato   e-5\staccato    d4-4   bes-2    
  r    c8.-1 d16  e8\staccato   c\staccato    e-2\staccato    f-3\staccato    
  g4-4   e8-1\staccato   g-3\staccato    aes4-4   f-2    
  e4   \motif e f g e g8-2\staccato    c-5\staccato    
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
