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
pad = \new Staff \with { instrumentName = "Pad" } {
  \relative c' {
    \leadLine { e2 d f d e d f d }
  }
}

makeOctaves = #(define-music-function (arg mus) (integer? ly:music?)
                 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))

padChords = \new ChordNames \chordmode {
  c2 g:sus4/c f/c g:sus4/c
  c2 g:sus4/c f/c g:sus4/c

}
synth = \new Staff {
  \relative c'' {
    s1 * 8

    f4 e8 d c4
  }
}

piano = \new PianoStaff \with { instrumentName = "Piano" } <<
  \new Staff = "up" {
    R1 * 4

    \relative c''' {
      \grace g16( \grace c16 \makeOctaves #-1 {
        e8.() c16 g4) d'8( c d e |

        \tuplet 3/2 { d4 c8 }
        \tuplet 3/2 { c4) \ottava #1 aes'8(  }
        \tuplet 3/2 { aes4 g8 }
        g8 f8 |

        e8.)( f16 g8. a16 b8 c d e | d8. c16 c4) \ottava #0 r2
      } |
      e,,8. c16 g4 d'8 c d e | g8. e16 e4 r2 |
      e8. f16 g8. a16 b8 c d e d16. c8 c4 \fermata r2 |
    }
  }
  \new Staff = "down" {
    \clef bass
    R1 * 4
    \relative c {
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
>>

\score {
  <<
    \padChords
    \pad
    \piano
  >>

  \layout {
    \context {
      \Staff
      \RemoveEmptyStaves
    }
  }
  \midi {}
}
