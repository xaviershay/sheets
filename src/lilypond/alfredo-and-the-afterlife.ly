\version "2.24.4"

% By ear from original and this how to:
% https://www.youtube.com/watch?v=1LnSctS9iVY

\header {
  title = "ALFREDO AND THE AFTERLIFE (INTRO)"
  composer = "Moron Police"
  poet = \markup { \italic "Transcribed by Xavier Shay" }
  tagline = \markup { \column { "" } }
}

\paper {
  bookTitleMarkup = \markup {
    \override #'(baseline-skip . 3.5)
    \column {
      \fill-line { \fromproperty #'header:dedication }
      \override #'(baseline-skip . 3.5)
      \column {
        \fill-line {
          \huge \larger \larger \bold
          \fromproperty #'header:title
        }
        \fill-line {
          \large \bold
          \fromproperty #'header:subtitle
        }
        \fill-line {
          \smaller \bold
          \fromproperty #'header:subsubtitle
        }
        \fill-line {
          \null
          \fromproperty #'header:composer
          \fromproperty #'header:poet
        }
        \fill-line {
          \fromproperty #'header:meter
          \fromproperty #'header:arranger
        }
      }
    }
  }
}

myTabclef =
  #(define-music-function () ()
   #{
      \override Staff.Clef.stencil = #ly:text-interface::print
      \override Staff.Clef.text = \markup {
        \vcenter
          \fontsize #-4
          \override #'(baseline-skip . 1.5)
          \center-column
          \sans \bold \whiteout { E C G C G C }

        % Select classic or modern TAB; comment out the one you don't
        % want to use.

        % music glyph version
        \vcenter \musicglyph "clefs.tab"
     }
   #})

drh = \drummode {
  cymc4 hh hh hh hh hh hh hh
  hh hh hh hh hh hh hh hh
  hh hh hh hh hh hh hh hh
  hh hh hh hh |

  \time 4,3 7/16

  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc8 cymc cymc8.
  cymc4 r8.
  cymc4 r8.
}
drl = \drummode {
  bd8 bd r4 sn4 r4
  r8 bd8 r8. bd16 sn4 r4
  bd8 bd r8. bd16 sn8. sn16 r8 sn16 sn16
  bd8 bd r8. bd16 sn8 bd16 sn16 r16 bd16 sn sn

  bd8 bd r4 sn4 r4
  r8 bd8 r8. bd16 sn4 r8 sn16 sn
  bd8 bd sn16 sn bd sn r16 bd8 bd16
  r16 sn sn sn |
  \time 4,3 7/16
  bd8 bd sn16 sn bd | sn8 bd bd sn16 |
  bd8 bd sn16 sn bd | sn16 bd sn bd sn bd sn |
  bd8 bd bd16 bd sn | bd8 bd bd sn16 |
  bd8 bd sn16 sn bd | sn8 bd bd sn16 |
  bd8 bd sn16 bd bd | sn8 bd bd sn16 |
  bd8 bd sn16 bd bd | sn8 bd bd sn16 |
  bd8 bd bd sn16 | <<bd4 sn4>> s8. | <<bd4 sn4>> s8.

}

minFret =
#(define-music-function (fret music) (integer? ly:music?)
   #{
     \set TabStaff.minimumFret = #fret
     #music
     \set TabStaff.minimumFret = #0
   #})

guitarNotes = {
  \set TabStaff.restrainOpenStrings = ##t
      c8 -\tag #'tab ^\markup { "Capo 5" } c8 e16 f16 g16 bes16~ bes16 f8 a16~ a16 bes16 a8 |
      \minFret #5 { g8 } c,8

      \minFret #4 { e16 f16 g16 f16~ f16 }

      c8 des16~ des16
      \minFret #4 { f16 }
      des8 |

      c8 c8 \minFret #3 { e16 g16 bes16 c16 e16 c16 e16 f16 e16 c16 bes8 }
      f16 g gis a c d dis e~ e f, bes f e' c bes8


      c,8 c8 e16 f16 g16 bes16~ bes16 f8 a16~ a16 bes16 a8
      \minFret #7 { g8 } c,8 \minFret #3 { e16 f16 g16 f16~ f16 } c8 des16~ des16 \minFret #4 { f16 } des8
      c8 c8 g'16 f e aes~ aes e8 aes,16~ aes e'16 fis gis |
      \time 4,3 7/16
      a8 a, a16 a' b | \minFret #5 { c8 } b a b16 | f8 f a16 c d | e8 e e f16 |
      c8 c e16 f g | aes8 g f g16 | e8 c8 \minFret #4 { e16 f fis } | \minFret #7 { fis'8 e c d16 } |
      \minFret #5 { g,8 g f16 g gis | d'8 c bes c16 | f,8 f } aes16 f c |
      aes8 bes \minFret #5 { c } d16 | ees8 \minFret #4 { f g bes16 | c4~ c8. } | \minFret #9 { d4~ d8. |}
      \bar "||"
      }
\score {
<<
    \new StaffGroup \with { instrumentName = "Lead" } <<
    \new Staff \relative c' {
      \tempo 4 = 168
      \removeWithTag #'tab \guitarNotes
    }
    \new TabStaff \with {
      \myTabclef
      stringTunings = \stringTuning <c, g, c g c' e'>
      \revert TextScript.stencil
    } {
      \transpose c g,,
      \relative c' {
        \guitarNotes
      }
    }
    >>
    \new DrumStaff \with { instrumentName = "Drums" } {
      <<
        \new DrumVoice { \stemUp \drh }
        \new DrumVoice { \stemDown \drl }
      >>
    }
  >>

  \layout {}
  \midi {}
}
