\version "2.10.10"
\header {
 title = "Big Apple Contest"
 arranger = "Arranged by Solomon Douglas"
 tagline = \markup {
   \column {
     "Transcribed by Xavier Shay"
     "Creative Commons Attribution License"
     "Melbourne, 16th March 2009"
   }
 }
}

#(set-global-staff-size 16)

\include "common.ly"

% ############ Horns ############

\include "trumpet.ly"

trpharmony = \transpose c' d {
 \jzchords
}
trumpet = {
 \global
 \set Staff.instrumentName = #"Trumpet"
 \clef treble
 <<
   \trpt
 >>
}

% ------ Alto Saxophone ------
\include "alto.ly"

altoharmony = \transpose c' a \chordmode {
 \jzchords
}
altosax = {
 \global
 \set Staff.instrumentName = #"Alto Sax"
 \clef treble
 <<
   \alto
 >>
}

% ############ Rhythm Section #############

% ------ Guitar ------
gtr = \relative c'' {
 \Key
\set Score.skipBars = ##t
 R1 * 6
 \sl 
 % A
 \repeat unfold 32 { bes4 bes bes bes }

 % B
 \repeat unfold 32 { bes4 bes bes bes }

 % C
 \repeat unfold 32 { bes4 bes bes bes }
 \repeat unfold 16 { bes4 bes bes bes }

  \cadenzaOn 
  \stopStaff
     \once \override TextScript #'word-space = #1.5
        % Increasing the unfold counter will expand the staff-free space
        \repeat unfold 4 {
          s4 s4 s4 s4
          \bar ""
        }
     \startStaff
   \cadenzaOff
 \nsl
 \override Staff.NoteHead #'style = #'slash
 bes8 r r bes r4 bes4~\fermata |
 bes1
}
gtrharmony = \chordmode {
 \jzchords
 R1 * 6
 \repeat unfold 3 {
   bes2 bes/g c:min7 f:7
   bes bes/g c:min7 f:7
   bes bes:7/d ees e:dim
   f1:7 bes
   bes2 bes/g c:min7 f:7
   bes bes/g c:min7 f:7
   bes bes:7/d ees e:dim
   f1:7 bes

   d:7 s1 g:7 s1 c:7 s1 f:7 s1

   bes2 bes/g c:min7 f:7
   bes bes/g c:min7 f:7
   bes bes:7/d ees e:dim
   f1:7 bes
 }

 d:7 s1 g:7 s1 c:7 s1 f:7 s1

 bes2 bes/g c:min7 f:7
 bes bes/g c:min7 f:7
 bes bes:7/d ees e:dim
 f1:7 bes

  \repeat unfold 4 {
    s4 s4 s4 s4
    \bar ""
  }

 bes1 s1
}
guitar = {
 \global
 \set Staff.instrumentName = #"Guitar"
 \clef treble
 <<
   \gtr
 >>
}

% ------ Drums ------
jazzHats = \drummode { hh4 hh8 hh hh4 hh8 hh }
jazzRide = \drummode { cymr4 cymr8 cymr cymr4 cymr8 cymr }
up = \drummode {
 hh4 hh hh hh8 sn
 sn4 cymc r hh
 hh4 hh hh sn
 hh4 hh hh sn
 hh4 hh hh hh8 sn
 sn4 cymc r8 sn sn4

 % A
 \repeat unfold 7 { \jazzHats }
 hh4 hh8 hh hh8 sn8 sn4

 \repeat unfold 7 { \jazzHats }
 hh4 hh8 hh hh8 sn8 hh8 hh 

 \repeat unfold 8 { \jazzRide }
 \repeat unfold 8 { \jazzHats }

 \repeat unfold 32 { \jazzRide }

 \repeat unfold 32 { \jazzHats }
 \repeat unfold 16 { \jazzHats }

  \stopStaff
     \once \override TextScript #'word-space = #1.5
        % Increasing the unfold counter will expand the staff-free space
        \repeat unfold 4 {
          s4 s4 s4 s4
          \bar ""
        }
     \startStaff
   \cadenzaOff

 <hh sn>8 r hh <hh sn> r4 <sn cymc~>\fermata |
 cymc1
}

down = \drummode {
 s1 
 s4 bd s2
 s1 
 s1 
 s1 
 s4 bd4 s2

 % A
 s1 * 5
 s2 s4 s8 bd
 r4 r8 bd r4 r8 bd
 r4 r8 bd s2

 s1 * 5
 s2 s4 s8 bd
 r4 r8 bd r4 r8 bd
 r4 r8 bd s2
}

drumContents = {
 \global
 <<
   \set DrumStaff.instrumentName = #"Drums"
   \new DrumVoice { \voiceOne \up }
   \new DrumVoice { \voiceTwo \down }
 >>
}

%%%%%%%%% It All Goes Together Here %%%%%%%%%%%%%%%%%%%%%%

\score {
 <<
   \new StaffGroup = "horns" <<
     \new Staff = "trumpet" \trumpet
     \new ChordNames = "altochords" \altoharmony
     \new Staff = "altosax" \altosax
%     \new ChordNames = "barichords" \bariharmony
%     \new Staff = "barisax" \barisax
   >>

   \new StaffGroup = "rhythm" <<
     \new ChordNames = "chords" \gtrharmony
     \new Staff = "guitar" \guitar
     \new DrumStaff { \drumContents }
   >>
 >>

 \layout {
   \context { \RemoveEmptyStaffContext }
   \context {
     \Score
     \override BarNumber #'padding = #3
     \override RehearsalMark #'padding = #2
     skipBars = ##t
   }
 }

 \midi {
     \context {
       \Score
       tempoWholesPerMinute = #(ly:make-moment 208 4)
     }
 }
}

