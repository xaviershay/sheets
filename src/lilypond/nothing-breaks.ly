\version "2.24.4"
#(ly:set-option 'relative-includes #t)
\include "util/book-title.ly"
\include "util/instrument-label.ly"
\include "util/lead-line.ly"
\include "util/octavize.ly"

\header {
  title = "NOTHING BREAKS (A PORT OF CALL)"
  composer = "Moron Police"
  poet = \markup { \italic "Transcribed by Xavier Shay" }
  tagline = \markup { \column { "" } }
}

\paper {
  bookTitleMarkup = \markup \bookTitleFormat
    \fromproperty #'header:title
    \fromproperty #'header:composer
    \fromproperty #'header:poet
}

guitarChords = \new ChordNames \with { midiInstrument = "distorted guitar" } \chordmode {
  c2 g:sus4/c f/c g:sus4/c
  c2 g:sus4/c f/c g:sus4/c
  s1*5 |
  bes1 | s1
  g2 c2 |
  c1:m |
  aes1 |
  bes/f |
  \time 6/4
  f1 s2 |
  \time 4/4
  a1:m c f g a:m c f g c
  s1 s1 |
  \barNumberCheck #28
  \repeat unfold 5 { c d/c f:m/c s1 }
  c d f:m/c s1
  \barNumberCheck #52
  \repeat unfold 3 { c d/c f:m/c s1 }
  c e a:m
  \barNumberCheck #67
  f g e:m c f g a:m
  f e:m f:maj7 s1
  g a:m f g
  g a:m bes f
  g a:m f g
  g a:m bes f
  aes bes s4
  \barNumberCheck #96
  c1 d/c f:m s
  c d/c f:m s
  \barNumberCheck #104
  c d/c f:m s
  c d/c f:m s
  c d/c f:m s
  c e a:m
  c f
  \repeat unfold 4 { d:m c f g }
  \barNumberCheck #137
  f g e:m c f g a:m
  f e:m f:maj7 s1

  c e a:m bes
  c e a:m bes
}

guitarLeadNotes = {
  \relative c'' {
    \voiceOne
    e4. c8 g2 |
    \oneVoice
    d'4 c d e |
    d4. c8 c4. aes8 |
    aes4. g8 g4 f |
    e'4. c8 g2 |
    d'4 c d e |
    g4 \staccato r8 g8 \staccato r4 g4 \staccato
    \voiceOne r8 g8 \staccato r4 g4 \staccato \voiceOne \stemDown g~ |
    \bar "||"
    g1 |
  }
}

pianoTinkleNotes =  \relative c' {
  \tuplet 3/2 { a16\([ c e a c e] }
  f16[ e8.]
  \tuplet 3/2 { e16[ c a e c e] }
  g16 a16 g8 e f4.\)
}

synth = {
  \relative c'' {
    R1 \fermata
    \bar "||"

    f4^\markup \instrumentLabel "Lead" e8 d c2 |
    r2 a4 c |
    d4. e8 e2 |
    g4 f8 ees c4. c8~ |
    c2 c8 ees bes'4 |
    bes a8 g a2 |
    \time 6/4
    a4. g8 e4. d8  c2 |
    \time 4/4
    c'4. b8 a4 g e4 g d8 e16 d c4
    c8 a'~ a g e4 d8 c d c b c g2
    c'4. b8 a4 g e4 g d8 e16 d c4
    d2 e4 g d2 c2 |
    c4 r4 c4 r4 |
    c1~ c1

    g8^\markup \instrumentLabel "Banjo" c e d~ d2 |
    a8 d fis e~ e2 |
    aes,8 c f aes~ aes2 |
    R1 |
    g,8 c e d~ d2 |
    a8 d fis e~ e2 |
    f8.^\markup \instrumentLabel "Lead" g aes8 c8. aes c8 |
    f8. c aes8 g4 f |

    \bar "||"

  }
}

piano = \new PianoStaff \with { instrumentName = "Piano" } <<
  \new Staff = "up" {
    R1 * 4

    \repeat volta 2 {
      \relative c''' {
        \slashedGrace {g16 c16} <e e,>8.( <c c,>16 <g \parenthesize g,>4

        \slashedGrace { fis16 a } <d d,>8( \makeOctaves #-1 {
          c d e |

          \tuplet 3/2 { d4 c8 }
          \tuplet 3/2 { c4) \ottava #1 aes'8(  }
          \tuplet 3/2 { aes4 g8 }
          g8 f8 |

          e8.)( f16 g8. a16 b8 c d e | d8.  } <c \parenthesize c,>16 <c c,>4) \ottava #0 r2
        |
      }
    }
  }
  \new Staff = "down" \with {
  } {
    \clef bass
    R1 * 4
    \repeat volta 2 {
      \relative c {
        \grace s8 % HACK: Needed for correct rendering, known issue apparently.
        c16( g' c e
        g4)
        d,16( fis a c d4)
        \tuplet 3/2 { f,8 ( aes c } f4)
        \tuplet 3/2 { f8 ( c aes } g8 f )
      }
      \relative c' {
        c,16( g' c e)
        d,16( f a d)
        e,16( b' c8~ c4)
        \ottava #1
        a16( e' b' c~ c4)
        \ottava #0
        r2
      }
    }
    R1
  }
>>

% Crash 2: same notehead as crashcymbal, one step higher so it's
% visually distinct on the staff (default table puts both at same position).
drumStyleTable = #(alist->hash-table
                   (cons '(crashcymbalb xcircle #f 7)
                         (hash-table->alist drums-style)))

drh = \drummode {
  R1*8 |
  s1 |
  \bar "||"
  \barNumberCheck #10
  \voiceOne
  cymc4 cymc4 cymc4 cymc4 |
  cymc4 cymc4 cymc4 cymc4 |
  cymcb2 cymc2 |
  r2 r4. cymcb8 |
  r2 r16 cymc8.~ cymc4 |
  cymc2 cymc2 |
  \time 6/4
  s4 cymc4 cymc4 cymc4  cymc4 cymc4 |
  \time 4/4
  cymc2 r8 cymcb4. |
  cymc2 s2 |
  r2. cymcb4 |
  r2 cymc2 |
  cymc2 cymc4 cymc4 |
  cymc4 cymc4 cymc4 cymc4 |
  cymc2 r8 cymcb8~ cymcb4 |
  r4 cymcb4 cymc8 cymc8~ cymc4 |
  r4 cymc4 r4 cymc4 |
  s1*2 |
  \bar "||"
  cymc4. hh8
  % Without this override, rest positions alternate between two spots (given the
  % part underneath), which doesn't match the consistent rhythm. Fixing to a set
  % height easier to read.
  \override Rest.staff-position = #6
  r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  \bar "||"
  cymc8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh16 hh |
  hh8 hh s4 s2

  cymc8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 s4
  s1

  \revert Rest.staff-position
  \bar "||"
  \barNumberCheck #52
  cymc4 hh hh hh |
  \repeat unfold 7 { hh hh hh hh }
  cymc4 hh hh hh |
  \repeat unfold 2 { hh hh hh hh }
  hh hh hh s |
  cymc1 |
  s1
  cymc2 r8 cymcb8~ cymcb4 |

  \bar "||"
  \barNumberCheck #67
  cymc8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  \repeat unfold 2 { rb8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 | }
  cymc2. cymc4 |
  cymc8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  rb8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  cymc4. cymc4. cymc4 |
  r4. cymc8~ cymc2 |
  s1 |
  cymc2~ cymc4. \tuplet 3/2 { cymr16_( cymr cymr } |
  cymr4) \oneVoice r4 r2 \voiceOne
  \bar "||"
  \barNumberCheck #78

  \repeat unfold 5 { \repeat unfold 8 { hh8 } }
  hh hh hho4 s2 |
  cymc1 | s1 |
  \repeat unfold 5 { \repeat unfold 8 { hh8 } }
  hh hh hho4 s2 |
  \barNumberCheck #92
  cymc4 hhho2 r8 cymc8~ | cymc4 hhho4 s2 |
  cymc4 hhho2 r8 hhho8 \staccato |
  \oneVoice r8 \voiceOne hhho8 \staccato
  r8 hhho8 \staccato s2 s4

  \bar "||"
  \barNumberCheck #96

  cymcb4 cymc cymc cymc
  cymc cymc cymc cymc
  cymc cymc cymc cymc
  cymc cymc cymc2
  cymcb4 cymc cymc cymc
  cymc cymc cymc cymc
  s1*2
  \bar "||"
  \barNumberCheck #104

  cymc4 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  cymc4 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8 |
  cymc4. cymc8~ cymc2 |
  cymc8. cymc16~ cymc8 cymc8 cymc4 cymc4 |
  cymc4 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 rb8 cymr16 cymr16 rb8 cymr8
  rb8 cymr16 cymr16 rb8 cymr8 cymc4 cymc4 |
  cymc1 |
  s1 |
  cymc4. cymcb8~ cymcb2 |
  cymc1 |
  cymc4 hhho4 hhho hhho |
  \repeat unfold 4 { hhho hhho hhho hhho | }
  cymc4 hhho4 hhho hhho |
  \repeat unfold 2 { hhho hhho hhho hhho | }
  hhho4 hhho hhho s |

  \bar "||"
  \barNumberCheck #129

  \repeat unfold 8 { cymc4. cymc8~ cymc4 cymc4 | }

  \bar "||"
  \barNumberCheck #137

  cymc8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  \repeat unfold 2 { rb8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 | }
  cymc2. cymc4 |
  cymc8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  rb8 cymr16 cymr rb8 cymr8 rb cymr16 cymr rb8 cymr8 |
  cymc2. r8 cymcb8 |
  r4. cymc8~ cymc2 |
  cymc1 |
  cymc4 \fermata
}

drl = \drummode {
  R1*8
  \tempo 4 = 160
  r2 r8 \fermata
  \voiceTwo
  bd8 \slashedGrace sn8 sn4 |
  \bar "||"
  \barNumberCheck #10
  bd4 sn8 bd sn4 sn8 bd |
  sn bd sn bd sn bd  \slashedGrace sn sn bd |
  bd4 \slashedGrace sn8 sn bd bd4 sn8 bd |
  sn8 tomh16 tomh16 tommh tommh tommh8 tomml16 tomml16 bd bd sn sn bd8 |
  r8 bd sn4 bd16 sn bd8 sn bd |
  bd4 sn8 bd bd8 sn16 sn toml toml bd bd |
  \time 6/4
  sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd |
  \time 4/4
  bd8 sn16 sn sn8 sn16 sn sn sn bd8 sn16 sn bd8 |
  bd8. bd16 sn4 bd16 sn16 bd8 r16 bd sn8 |
  bd8 bd8 r16 bd16 sn8 bd16 bd8 bd16 sn8. \parenthesize sn16 |
  bd16 sn bd8 sn bd bd8. sn16 sn tomh tomh toml |
  sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd |
  sn8 bd16 bd sn8 bd16 bd sn8 bd16 bd sn8 bd8 |
  bd8 sn16 sn sn8 sn16 sn sn sn bd8 r16 bd sn8 |
  bd8. bd16 sn4 bd8 bd r16 bd sn sn |
  sn8 sn16 sn bd8 sn16 sn sn8 sn16 sn bd8. bd16 |
  sn8 sn8 r16 bd sn toml toml8. bd16 sn sn sn8 |
  r16 bd16 sn sn sn8. bd16 sn tomh tommh toml toml8. toml16 |
  \bar "||"
  bd8 bd sn bd r4 sn4 |
  r4 sn4 r4 sn4 |
  r4 sn4 r4 sn4 |
  r4 sn4 r4 sn4 |
  bd4 sn4 r4 sn4 |
  r4 sn4 r4 sn4 |
  bd8. bd16 sn8 bd8  bd8. bd16 sn8 bd8 |
  bd8. bd16 sn8 bd8  bd8 bd sn4 |
  \bar "||"

  bd4 sn8 bd8 r4 sn4
  bd4 sn8 bd8 r4 sn4
  bd4 sn8 \parenthesize bd8 r4 sn4
  bd4 sn8 bd8 r4 sn8 tomml16 toml
  bd4 sn8 bd8 r4 sn4
  bd4 sn8 bd8 r4 sn4
  bd4 sn8 bd8 r4 sn4
  r8 bd8 sn8 tomh tommh toml sn bd

  bd4 sn8 bd8 r4 sn4 |
  bd4 sn8 bd8 r4 sn4 |
  bd4 sn8 bd8 r4 sn4 |
  bd4 sn8 bd8 r4 sn8 tomml16 toml |
  bd4 sn8 bd8 r4 sn4 |
  bd4 sn8 bd8 r4 sn4 |
  bd4 sn8 bd8 r8 bd8 sn8 tomh16 tomh |
  tomh8 bd8 sn8 tommh toml bd sn bd |

  \bar "||"
  \barNumberCheck #52

  \repeat unfold 7 { bd8 bd sn bd r bd sn4 | }
  bd8 bd sn bd bd bd sn8 bd |
  \repeat unfold 3 { bd8 bd sn bd r bd sn4 | }
  bd8 bd sn bd bd bd sn16 sn sn sn |
  bd8. bd16 sn8 sn r16 sn sn8 tomh8. bd16 |
  bd16 toml toml8 r16 bd sn sn sn8. bd16 sn bd sn sn |
  bd4 sn8 bd r bd16 bd sn8 bd |

  \bar "||"
  \barNumberCheck #67
  \repeat unfold 3 { bd4 sn8 bd r bd sn4 | }
  bd8. bd16 sn16 bd sn8 r bd16 bd sn bd tomml toml |
  \repeat unfold 1 { bd4 sn8 bd r bd sn4 | }
  bd4 sn8 bd r bd sn16 sn bd8 |
  bd8. sn16 sn8 bd r bd sn bd |
  r bd sn16 sn16 bd8 r bd sn4 |
  sn8 bd bd tomh~ tomh tomml toml4 |
  bd4 r4 r2 | s1

  \bar "||"
  \barNumberCheck #78

  ss4 ss ss ss
  ss ss ss8 bd ss bd16 bd |
  <<bd4 ss4>> <<bd4 ss4>> ss ss |
  ss8 bd ss16 bd bd8 ss8 bd ss16 bd bd8 |
  ss4 ss ss8 bd ss bd |
  ss4 ss8 bd tomh16 tomh bd bd sn sn sn sn |
  bd8. bd16 sn4 bd8 bd r16 bd sn8 |
  r8 bd sn bd sn16 sn bd bd sn4 |
  ss ss ss ss |
  ss ss8 bd ss bd ss16 bd bd8 |
  <<bd4 ss4>> <<bd4 ss4>> ss ss |
  ss8 bd ss16 bd bd8 ss8 bd ss16 bd bd8 |
  ss4 ss ss8 bd ss bd |
  ss4 ss8 bd tomh16 tomh bd bd sn sn sn sn |
  bd4 sn8 bd tomh16 tomh toml toml sn sn bd8 |
  r bd sn bd tomml16 tomml toml toml sn bd sn sn |
  bd4 sn8 bd sn16 sn bd bd sn8 bd |
  s8 bd sn bd sn16 sn bd bd sn bd sn sn \oneVoice r4 \voiceTwo |

  \bar "||"
  \barNumberCheck #96
  bd4 sn8 bd bd bd sn bd
  bd bd sn bd bd bd sn bd
  bd bd sn bd bd bd sn bd
  bd bd sn bd bd sn sn4
  bd4 sn8 bd bd bd sn bd
  bd bd sn bd bd bd sn bd
  bd16 bd toml toml toml toml bd bd sn sn bd bd tommh tommh toml toml |
  bd bd sn sn sn sn bd bd sn sn bd bd sn tomh tommh toml |
  \bar "||"
  \barNumberCheck #104
  \repeat unfold 3 {
    bd4 sn8 bd8 r8 bd8 sn4 |
  }
  bd4 sn8 bd8 r8 bd16 bd sn bd sn8 |
  \repeat unfold 2 {
    bd4 sn8 bd8 r8 bd8 sn4 |
  }
  bd8. bd16 sn8 bd r16 sn bd8 sn8. sn16 |
  bd8. bd16~ bd8 bd 16 sn bd8. bd16 sn tomh tommh toml |
  \repeat unfold 3 {
    bd4 sn8 bd8 r8 bd8 sn4 |
  }
  bd8. bd16 sn bd sn8 r16 sn bd bd sn8 bd |
  bd4. bd8 sn16 sn bd bd tommh tommh tomml tomml |
  toml toml bd bd sn sn bd8 sn16 bd sn bd sn bd sn sn |
  bd4 sn8 bd r bd sn bd |
  sn8 bd bd sn sn bd sn16 sn sn sn |
  bd4 sn8 bd r bd sn4 |
  \repeat unfold 3 {
    bd4 sn8 bd r bd sn4 |
  }
  bd8 bd sn bd r bd16 bd sn8 bd |
  \repeat unfold 3 {
    bd8 bd sn8 bd r bd sn4 |
  }
  bd8 bd sn bd bd sn16 sn sn sn8 sn16 |

  \bar "||"
  \barNumberCheck #129

  bd8. bd16 sn8 bd r16 bd sn8 bd16 sn sn sn |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 tommh tomml toml |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 sn sn sn |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 tommh tomml toml |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 tommh tomml toml |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 sn sn sn |
  bd8. bd16 sn8 bd r16 bd sn8 bd16 sn sn sn |
  bd8. bd16 sn8 bd sn16 sn bd bd sn bd sn sn |


  \bar "||"
  \barNumberCheck #137

  bd4 sn8 bd r bd sn4 |
  bd4 sn8 bd r bd16 bd sn8 bd |
  bd4 sn8 bd r bd sn4 |
  bd8. bd16 sn8 sn8 r16 sn bd bd sn bd tomml toml |
  bd4 sn8 bd r bd sn4 |
  bd4 sn8 bd r bd16 bd sn8 bd16 bd |
  sn8 sn bd toml bd sn sn bd |
  r bd sn bd r bd sn8. bd16 |
  sn8 bd bd toml toml sn sn \oneVoice r \voiceTwo |
  bd4 \oneVoice r4 r2 | R1
}

leadVocals = \new Staff \with { instrumentName = "" } {
  \tempo 4 = 64
  \new Voice = "pad" {
    \relative c' {
      \leadLine { e2^\markup \instrumentLabel "Vox & Strings" d f d e d f d }

      \repeat volta 2 {
        \grace s8 % HACK: Needed for correct rendering, known issue apparently.
        <c g>2^\markup \instrumentLabel "Strings" <d a> <c aes>1 <c g>4 <d a> <e b>2 <c a>1
      }
    }
  }
  \new Voice = "synthy" {
    \synth
  }
  \new Voice = "lead" {
    \bar "||"
    \barNumberCheck #36
    \relative c'' {
      c4^\markup \instrumentLabel "Vocals" c8 c8~ c2 |
      c4 c8 c8~ c2 |
      c4 aes8 aes~ aes g~ g \appoggiatura f g~ g4. f8 f f~ f e8~ e2 r4. e8 |
      \appoggiatura bes' c2. d8 c8~ |
      c2 r2 |
      R1 |
      c8 c~ c c~ c4. c8 |
      d4 d8 d8~ d4. d8 |
      aes'4 g8 f d f8~ f4~ |
      f2 r2 |
      r4 bes,8 c r c~ c8 d8~ |
      d2. c8 c8~ |
      c2 r2 |
      r2 r4. c8 |
      \bar "||"

      <<
        {
          \voiceOne
          e8 e~ e e~ e d c d~ |
          d4 c d e |
          d c8 c~ c2
          r2 r8 e8 e e
          e4 e8 g~ g e d c |
          d4 c8 c~ c a~ a c~ |
          c4. aes8_( g2) |
          R1 | e'8 e~ e e~ e d c d~ |
          d4 c d e |
          d4. c c4~ |
          c2 r4. d,8 |
          e4. f8 g4. a8 |
          b4 c d e |
          d4. c8~ c c8~ c4 |
          \bar "||"
        }
        \new Voice = "backup" {
          \voiceTwo \relative c' {
            \teeny
            s1*2
            f8 f~ f f~ f f~ f f | f4 e d c d4. e8 e2
            s1 r2 c'4 c |
            c aes g f e4. e8~ e2
            fis8 fis~ fis fis~ fis fis~ fis fis |
            c'8 c~ c c~ c c~ c c |
            c,8 c~ c c~ c c~ c c |
          }
        }
      >> |

      \barNumberCheck #67
      \oneVoice
      e2~ e8 f e d8~ | d2. r4 |
      d2~ d8 e d c8~ | c2. r4 |
      e2~ e8 f e d8~ | d2. r8 d |
      e8. c16~ c8 g8~ g8 b8~ b a~ |
      a8 c~ c d~ d c~ c c |
      b4 g8 g~ g4 e8 a8~ |
      a1 |
      R1 |
      b2~ b8 a b c~ |
      c4. e8~ e d c b |
      a4 g g e8 g~ |
      g2 r2 |
      b2~ b8 a b c~ |
      c2 a8 c8~ c4 |
      d2. e8 c8~ |
      c2 r4. e,8 |
      b'2~ b8 a b c~ |
      c4 c8 e8~ e d c b |
      a4 g g e8 g~ |
      g2 r4. e8 |
      b'2~ b8 a b c~ |
      c2 a8 c8~ c4 |
      d2. e8 c8~ |
      c2 r2 |
      r4. f,8 g g'~ g f~ |
      \time 5/4
      f e~ e d~ d c~ c2 |
      \bar "||"
      \time 4/4
      <<
        {
          \voiceTwo
          c1 |
          s1
          s1*5
          \voiceTwo r2. r8 c8
          \bar "||"
          \barNumberCheck #104
          e8 e~ e e~ e d c d~ |
        }
        \new Voice = "guitar" { \guitarLeadNotes }
      >>
      \oneVoice
      d4 c d e |
      d4. c4. c4~ |
      c2. e8 e
      e4 e8 g~ g g g a~ |
      a g~ g e~ e f~ f4 |
      e2~ e8 d c4 |
      g2. r8 c8 |
      e8 e~ e e~ e d c d~ |
      d4 c d e |
      d4. e4. c4~ |
      c2. r8 d,8 |
      e4. f8 g4. a8 |
      b4 c d e |
      d4. c8 c4. c8 |
      a'4. g8 e4. d8 |
      c2. r4 |
      c4 b~ b8 a~ a g |
      e4 g c, c8 c8 |
      c'4 b~ b8 a~ a g |
      d2. r8 c
      c' b~ b8 a~ a g~ g4  |
      e  g g g8 g |
      a4. a8 a a g4~ |
      g2. r8 g8 |

      \barNumberCheck #129

      e'8 e~ e e~ e4. e8 |
      d8 c~ c c~ c4 c8 c |
      c4 a8 c~ c c~ c d~ |
      d2 d8 e~ e4 |
      f2. e4 | d8( c4.~) c8 c~ c c~ |
      c4. e8~ e d c d~ |
      d2 r2 |

      \barNumberCheck #137

      e2~ e8 f e d8~ | d2. r4 |
      d2~ d8 e d c8~ | c2. r4 |
      e2~ e8 f e d8~ | d2. r8 d |
      e8. c16~ c8 g8~ g8 b8~ b a~ |
      a8 c~ c d~ d c~ c c |
      b4 g8 g~ g4 e8 a8~ |
      \tempo 4 = 64
      <<
        { a1 \fermata  s1 | }
        \new Voice = "blah" { \teeny s2 s1*0^\markup \instrumentLabel "Piano free time" \pianoTinkleNotes }
      >>

      \bar "||"
      \barNumberCheck #148

      \teeny
      r8 g^\markup \instrumentLabel "Backup Vocals" g g g g e g |
      gis e~ e d16 e d8 c~ c c |

      a c e4~ e8 e8~ e d16 c |
      d8. d16 d8 e d16( c8.~) c4 |
      r8 g'~ g e g16 e8 g16~ g8 g |
      \grace g( gis8.) e16 e8. e16 d8 c~ c8. c16 |
      a'8 g e16( d c8~) c4 a8 c |
      d8. d16 d8 c f e~ e4 \fermata |

      \bar "|."
    }
  }
}

leadWords = \new Lyrics \lyricsto "lead" {
  Wa -- king up, feel the wind suf -- fo -- cate my throat for what I am
  A -- live a -- gain
  When it hurts, I shut it off
  through suf -- fe -- ring and pain I lost my spark a -- gain

  But no -- thing breaks like a man that's gi -- ven ev -- ery -- thing
  He does -- n't need to walk, he does -- n't need to see things your way
  No -- thing breaks like a wave that knows the wait -- ing shore
  It's all the things I know I should have said be -- fore

  Know what you do
  Hold what you can
  Live for a while

  And wear your heart up -- on your sleeve
  when your boat be -- comes the shore

  Rest for a while, all the lit -- tle
  life -- times trapped in -- side
  Speak them by name I will soon be gone
  To where I be -- long
  A ghost can live a life -- time trapped in song
  They're shout -- ing my name from a thou -- sand stars
  I know ex -- act -- ly where they are

  And no -- thing wakes like a man who's seen the o -- ther side
  If the earth would shake, it would till the flow -- ing tide on its name
  Yes, no -- thing breaks like a man who's seen the o -- ther side

  I'm stuck in -- side a cage I can -- not leave be -- hind
  And here we go a -- gain

  Won -- dering where the lights will go
  as they roll me from the floor

  I've gi -- ven up on all my dreams
  I don't need them a -- ny -- more
  Well, no -- thing rocked, and no -- thing rolled
  in this god -- for -- sa -- ken town
  I am lea -- ving you to be

  See you a -- round

  Love what you do
  Cry if you can
  Sing like you're damned
  And wear your heart u -- pon your sleeve
  when your boat be -- comes the shore


  \teeny
  I ne -- ver said it would be hea -- ven in a nut -- shell
  But more than this, I think
  your soul will start to tire

  All the lit -- tle hopes and dreams you had ac -- quir -- ed,
  they weigh you down

  Now you're bur -- ning in the fi -- re
}

backupWords = \new Lyrics \lyricsto "backup" {
  \teeny No -- thing breaks like a man that's gi -- ven ev -- ery thing
  does -- n't need to see things your way
  No -- thing breaks like a
  No -- thing breaks like a
  No -- thing breaks like a
}

\score {
  <<
    \guitarChords
    \leadVocals
    \leadWords
    \backupWords
    \piano
    \new DrumStaff \with { instrumentName = "Drums" drumStyleTable = #drumStyleTable } {
      <<
        \new DrumVoice { \stemUp \drh }
        \new DrumVoice { \stemDown \drl }
      >>
    }
  >>

  \layout {
    \context {
      \Staff
      \RemoveEmptyStaves
    }
  }
  \midi {}
}
