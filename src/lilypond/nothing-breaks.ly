\version "2.24.4"

\header {
  title = "NOTHING BREAKS (A PORT OF CALL)"
  composer = "Moron Police"
  arranger = \markup { \italic "Transcribed by Xavier Shay" }
  tagline = \markup { \column { "" } }
}

% "Lead line" / "Top line" notation: a notehead with a stem extending on
% both sides.
%
% https://music.stackexchange.com/questions/133478/is-there-a-way-to-indicate-the-top-note-of-a-chord-symbol
leadLine =
#(define-music-function (music) (ly:music?)
   #{
     \override Stem.stencil =
     #(lambda (grob)
        (let ((s (ly:stem::print grob)))
          (ly:stencil-translate-axis (ly:stencil-scale s 1 1.5) -1.5 Y)))
     #music
     \revert Stem.stencil
   #})

instrumentLabel =
#(define-markup-command (instrumentLabel layout props text) (markup?)
   (interpret-markup layout props
                     (markup #:italic #:fontsize -3 text)))

% https://wiki.lilypond.community/wiki/Adding_automatic_octaves_to_a_melody
#(define (octave-up m t)
   (let* ((octave (1- t))
          (new-note (ly:music-deep-copy m))
          (new-pitch (ly:make-pitch
                      octave
                      (ly:pitch-notename (ly:music-property m 'pitch))
                      (ly:pitch-alteration (ly:music-property m 'pitch)))))
     (set! (ly:music-property new-note 'pitch) new-pitch)
     new-note))

#(define (octavize-chord elements t)
   (cond ((null? elements) elements)
         ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
          (cons (car elements)
                (cons (octave-up (car elements) t)
                      (octavize-chord (cdr elements) t))))
         (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
   (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
                                                (ly:music-property music 'elements) t)))
   music)
pad = \new Staff \with { instrumentName = "Pad" midiInstrument = "pad 2 (warm)" } {
  \tempo 4 = 60
  \relative c' {
    \leadLine { e2^\markup \instrumentLabel "Vox & Strings" d f d e d f d }

    \repeat volta 2 {
      \grace s8 % HACK: Needed for correct rendering, known issue apparently.
      c2^\markup \instrumentLabel "Strings" d f1 c4 d e2 a,1
    }
  }
}

makeOctaves = #(define-music-function (arg mus) (integer? ly:music?)
                 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))

padChords = \new ChordNames \with { midiInstrument = "pad 2 (warm)" } \chordmode {
  c2 g:sus4/c f/c g:sus4/c
  c2 g:sus4/c f/c g:sus4/c
  c
}

synth = \new Staff \with { instrumentName = "Lead" midiInstrument = "lead 2 (sawtooth)" } {
  \relative c'' {
    R1*8
    R1 \fermata
    \bar "||"

    f4 e8 d c2 |
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
    c4
    r4
    c4
    r4
    c1~ c1

    g8 c e d~ d2 |
    a8 d fis e~ e2 |
    \hide NoteHead
    % I don't have this bit yet
    c8 c c c~ c2 |
    \undo \hide NoteHead
    R1 |
    g8 c e d~ d2 |
    a8 d fis e~ e2 |
    f8. g aes8 c8. aes c8 |
    f8. c aes8 g4 f |

    \bar "||"

  }
}

piano = \new PianoStaff \with { instrumentName = "Piano" } <<
  \new Staff = "up" {
    R1 * 4

    \repeat volta 2 {
      \relative c''' {
        \slashedGrace {g16^( c16} <e) e,>8.( \makeOctaves #-1 {
          c16 g4) d'8( c d e |

          \tuplet 3/2 { d4 c8 }
          \tuplet 3/2 { c4) \ottava #1 aes'8(  }
          \tuplet 3/2 { aes4 g8 }
          g8 f8 |

          e8.)( f16 g8. a16 b8 c d e | d8. c16 c4) \ottava #0 r2
        } |
      }
    }
    R1
  }
  \new Staff = "down" \with {
  } {
    \clef bass
    R1 * 4
    \repeat volta 2 {
      \relative c {
        \grace s8 % HACK: Needed for correct rendering, known issue apparently.
        % TODO: Place note in top staff and slur to it: https://music.stackexchange.com/questions/63372/how-can-i-change-slur-from-above-to-below-notes-when-switching-staff-in-lilypond
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
  cymc4 cymc4 cymc4 cymc4 |
  cymc4 cymc4 cymc4 cymc4 |
  cymcb2 cymc2 |
  s2 s4. cymcb8 |
  s2 s16 cymc8. s4 |
  cymc2 cymc2 |
  \time 6/4
  s4 cymc4 cymc4 cymc4  cymc4 cymc4 |
  \time 4/4
  cymc2 s8 cymcb8 s4 |
  cymc2 s2 |
  s2. cymcb4 |
  s2 cymc2 |
  cymc2 cymc4 cymc4 |
  cymc4 cymc4 cymc4 cymc4 |
  cymc2 s8 cymcb8 s4 |
  s4 cymcb4 cymc8 cymc8 s4 |
  s4 cymc4 s4 cymc4 |
  s1*2 |
  \bar "||"
  cymc4. hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  r8 hh8 r8 hh8 r8 hh8 r8 hh8 |
  \bar "||"

}

drl = \drummode {
  R1*8
  \tempo 4 = 160
  r2 r8 \fermata bd8 \acciaccatura sn8 sn4 |
  \bar "||"
  bd4 sn8 bd sn4 sn8 bd |
  sn bd sn bd sn bd  \acciaccatura sn sn bd |
  bd4 \acciaccatura sn8 sn bd bd4 sn8 bd |
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
  bd8 bd sn bd s4 sn4 |
  s4 sn4 s4 sn4 |
  s4 sn4 s4 sn4 |
  s4 sn4 s4 sn4 |
  bd4 sn4 s4 sn4 |
  s4 sn4 s4 sn4 |
  bd8. bd16 sn8 bd8  bd8. bd16 sn8 bd8 |
  bd8. bd16 sn8 bd8  bd8 bd sn4 |
  \bar "||"
}

leadVocals = \new Staff \with { instrumentName = "Vocals" } {
  \new Voice = "lead" {
    s1*35 s2
    \relative c'' {
      c4 c8 c8~ c2 |
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
      r2 r4. r8 |
      \bar "||"

    }
  }
}

leadWords = \new Lyrics \lyricsto "lead" {
  Wa -- king up, feel the wind suf -- fo -- cate my throat for what I am
  A -- live a -- gain
  When it hurts, I shut it off
  Through suf -- fe -- ring and pain I lost my spark a -- gain

  But no -- thing breaks like a man that's gi -- ven ev -- ry -- thing
  He does -- n't need to walk, he does -- n't need to see things your way
  No -- thing breaks like a wave that knows the wait -- ing shore
  It's all the things I know I should have said before
}

\score {
  <<
    \leadVocals
    \leadWords
    \padChords
    \pad
    \piano
    \synth
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
