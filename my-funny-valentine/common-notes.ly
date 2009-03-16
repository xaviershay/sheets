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

harmonies = \chordmode {
  \override ChordName #'font-size = #0.3
  \transpose c g' {
    \set chordNameExceptions = #chExceptions 
    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a

    aes1 f:min7 f2:min6 g:7 f:min g:7

    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a

    aes1 f:min7 aes:min bes:7

    ees2 bes4:7sus4 bes:7
    ees2 bes4:7sus4 bes:7
    ees2 bes4:7sus4 bes:7
    ees2 bes4:7sus4 bes:7
    g2 g:aug
    c1:min aes2 aes aes:7 g:7

    c1:min c2:min7/bes c:min6/a
    c1:min c2:min7/bes c:min6/a
    aes1 d2:7^5 g:7 c1:min ees:7
    aes2 aes f:min7 bes:7
    ees1 s
  }

}

melody = \transpose c g' {
  \set Score.markFormatter = #format-mark-box-letters 
  \mark \default
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
  \break
  
  \bar "||"
  \mark \default

  bes4 r8 ees,8 ees4 d
  ees2 ees4 d |
  c' r8 ees,8 ees4 d 
  ees2 ees4 d d' r8 ees,8 ees4 d |
  ees2 f4 g c1~ c2 d, |

  \break
  \bar "||"
  \mark \default

  c2 d4 ees d4. ees8 d2 
  ees2 f4 g f4. g8 f2
  c'2 d4 ees d4. ees8 d2
  ees1~ ees1 | 
  ees,2 f4 g f4. g8 f2
  ees1~ ees
  \bar "|."
  }
}
