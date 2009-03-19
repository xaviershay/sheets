% Exception music is chords with markups 
chExceptionMusic = { 
<c e g b d'>1-\markup { \super "maj9" } 
<c e g a d'>1-\markup { \super "6(add9)" } 
<c e bes>1-\markup { \super "7-5" } 
<c f g bes>1-\markup { \super "7sus" } 
} 
% Convert music to list and prepend to existing exceptions. 
chExceptions = #( append 
( sequential-music-to-chord-exceptions chExceptionMusic #t) 
ignatzekExceptions) 

harmonies = \transpose c g, \chordmode {
  \override ChordName #'font-size = #0.3
  \set chordNameExceptions = #chExceptions 
  
  \partial 8 s8
  bes1 s1 s1 bes:7
  ees:7 s1 bes:7 s1
  f:7 c2:7 f:7 bes1 s1

  bes1:7 ees:7 bes s1
  ees:9 s2 f:7 bes1 f1:7
  c2:7 f:7 bes1 s1
  \bar "||"

  ees1:9 ees2.:min6 f4:7 |
  des1:7 c2:aug c:7 |
}

melody = \transpose c g {
  \set Score.markFormatter = #format-mark-box-letters 
  \mark \default
  \relative c' {
    \key bes \major
    \partial 8 f8 |
    \times 2/3 { a8 bes f } a8 bes~ bes4. f8 |
    \times 2/3 { a8 bes f } a8 bes~ bes4. f8 |
    \times 2/3 { a8 bes f } a8 bes~ bes2 |

    d,2~ d4. bes8 |
    \times 2/3 { f'8 ees bes } f'8 ees~ ees4. bes8 |
    \times 2/3 { f'8 ees bes } f'8 ees~ ees2 |
    r8 bes' aes g f g cis, d~ |
    d2~ d4. f8 |
    \times 2/3 { b c f, } b8 c~ c4. f,8 |
    \times 2/3 { des' c des } bes8 bes \times 2/3 { aes g aes } f8 f |
    a bes~ bes2~ \times 2/3 { bes8 g f } |
    bes,1 |
  }
  
  \relative c'' {
    \mark \default
    d4. f8 d bes g f |
    des'4. f8 des bes g f |
    cis' d4.~ d4. f,8 |
    \times 2/3 { a bes f } a8 bes~ bes2 |
    des4. f8 des bes g f |
    ees'4. f8 ees des bes ges |
    cis8 d4.~ d4. f,8 |
    \times 2/3 { e' f f, } e'8 f~ f4. f,8 |
    \times 2/3 { des' c des } bes8 bes \times 2/3 { aes g aes } f8 f |
    a bes~ bes2~ \times 2/3 { bes8 g f } |
    bes,2~ bes8 f' g bes |
    c4. bes8 c4. bes8 |
    ees4. des8 ees des ees f |
    bes,4. aes8 bes4. aes8 |
    des1 |
  }
}
