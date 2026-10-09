
\version "2.24.4"
#(ly:set-option 'relative-includes #t)
\include "util/book-title.ly"
\include "util/labeled-tab-clef.ly"

% By ear from original and this how to:
% https://www.youtube.com/watch?v=1LnSctS9iVY

\header {
  title = "PACHINKO (ASSORTED SNIPPETS)"
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
drh = \drummode {
}
drl = \drummode {
    \time 4/4
    r2 r4. bd8 \accent |
    r8 bd8 sn4 bd8 bd sn bd \accent |
    \time 2,2,2,2,3 11/8
    r8 bd8 sn4 bd8 bd sn bd sn bd bd \accent |
    \time 4/4
    r8 bd8 sn4 bd8 bd sn bd |
    \time 2,2,2,2,3 11/8
    bd4 sn4 bd8 bd sn bd r bd bd \accent |
    \time 4/4
    r8 bd8 sn4 bd8 bd sn bd \accent |
    \time 2,2,2,2,3 11/8
    r8 bd8 sn4 bd8 bd sn bd sn bd bd \accent |
    \time 4/4
    r8 bd8 sn4 bd8 bd sn bd |
    r8 bd sn bd sn bd tomml bd \accent |
}
leadNotes = {
    \key d \major
    r2 r4. \xNote { d8 \accent } |
    r4 fis8 f fis4 r8 \xNote { d8 \accent } |
    r4 fis8 f fis f fis d8~ d4 \xNote { d8 \accent } |
    r4 fis8 f fis4 r4 |
    g4 g g8 a g fis~ fis4 \xNote { d8 \accent } |

    r4 fis8 f fis4 r8 \xNote { d8 \accent } |
    r4 fis8 f fis f fis d8~ d4 \xNote { d8 \accent } |
    r4 fis8 f fis4 r8 d~ |
    d \accent fis g a c a g d \accent |
}
chordText = \new ChordNames {
  \chordmode {
    s2 s4. d8 |
    s1 | s1 s4. | s1 |
    g1 s4 d8 |
  }
}

\score {
<<
    \chordText
    \new StaffGroup \with { instrumentName = "Lead" }
    \new Staff \relative c' {
      \tempo 4 = 168
      \leadNotes
    }
    \new DrumStaff \with { instrumentName = "Drums" } {
      <<
        \new DrumVoice { \stemUp \drh }
        \new DrumVoice { \stemDown \drl }
      >>
    }
  >>

  \header {
    piece = "PACHINKO, PT. 1 (INTRO)"
  }
  \layout {}
  \midi {}
}

kittensLead = {
    r2 r4 \repeat volta 2 { f8 g | r a~ a4 g8 r a8 r  |
   \time 5/4
    r c~ c4 g f8 e r4
    \time 4/4
    f e8 f r a r4
    \time 2/4 d,2
    \time 4/4
    c4 a8 c r g' r f~
    \time 5/4
    f2
    c8 d f g r4
    \time 4/4
    a bes8 a r f r g~ g2.
    }
}

\score {
<<
    \new StaffGroup \with { instrumentName = "Lead" }
    \new Staff \relative c' {
      \tempo 4 = 168
      \kittensLead
    }
    % \new DrumStaff \with { instrumentName = "Drums" } {
    %   <<
    %     \new DrumVoice { \stemUp \drh }
    %     \new DrumVoice { \stemDown \drl }
    %   >>
    % }
  >>

  \header {
    piece = "KING AMONG KITTENS (INTRO)"
  }
  \layout {}
  \midi {}
}
