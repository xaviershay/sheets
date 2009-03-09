\version "2.10.10"
\header {
 title = "Big Apple Contest"
 composer = "Solomon Douglas"
 meter = "fast"
 piece = "Swing"
 tagline = \markup {
   \column {
     "Xavier Shay"
     "Melbourne, 9th March 2009"
   }
 }
 texidoc = "Jazz tune for combo
            (horns, guitar, piano, bass, drums)."
}

#(set-global-staff-size 16)

%%%%%%%%%%%% Some macros %%%%%%%%%%%%%%%%%%%

sl = {
 \override NoteHead #'style = #'slash
 \override Stem #'transparent = ##t
}
nsl = {
 \revert NoteHead #'style
 \revert Stem #'transparent
}
cr = \override NoteHead #'style = #'cross
ncr = \revert NoteHead #'style

%% insert chord name style stuff here.

jzchords = { }


%%%%%%%%%%%% Keys'n'thangs %%%%%%%%%%%%%%%%%

global = {
 \time 4/4
}

Key = { \key bes \major }

% ############ Horns ############

% ------ Trumpet ------
trpt = \transpose c d \relative c'' {
 \Key

  bes8 bes r bes bes bes r bes 
  bes4 bes,2. 
  bes'8 bes r bes bes4 r |
  bes8 bes r bes bes4 r |
  bes8 bes r bes bes bes r bes 
  bes4 bes,~ bes8 bes'~ bes bes~ 
  \bar "||"

  % A
    bes bes~ bes4 a8 bes r4 |
    r2 r8 bes8~ bes bes~ |
    bes bes~ bes4 a8 bes r4 |
    r2 r8 bes8~ bes bes~ |
    bes bes~ bes4 a8 bes r4 |
    r2 r4 r8 bes,8~ |
    bes4~ bes8 bes~ bes4~ bes8 bes8~ |
    bes4~ bes8 bes~ bes8 bes'~ bes bes~ |

    bes bes~ bes4 a8 bes r4 |
    r2 r8 bes8~ bes bes~ |
    bes bes~ bes4 a8 bes r4 |
    r2 r8 bes8~ bes bes~ |
    bes bes~ bes4 a8 bes r4 |
    r2 r4 r8 bes,8~ |
    bes4~ bes8 bes~ bes4~ bes8 bes8~ |
    bes4~ bes8 bes~ bes4 r |
}
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
alto = \transpose c a \relative c' {
 \Key
 bes8 bes r bes bes bes r bes 
 bes4 bes,2. 
 bes'8 bes r bes bes4 r |
 bes8 bes r bes bes4 r |
 bes8 bes r bes bes bes r bes 
 bes4 bes,2. |

 % A
 \repeat unfold 2 {
   r2 r4 r8 bes8~ |
   bes8 bes~ bes4 d8 f r4 |
   r2 r4 r8 bes,8~ |
   bes8 bes~ bes4 g8 f r4 |
   r2 r4 r8 bes8~ |
   bes8 bes~ bes4 d8 f r8 bes,8~ |
   bes4~ bes8 bes~ bes4~ bes8 bes8~ |
   bes4~ bes8 bes~ bes4 r  |
 }
}
altoharmony = \transpose c' a {
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

% ------ Baritone Saxophone ------
bari = \transpose c a' \relative c {
 \Key
 c1 c \sl d4^"Solo" d d d \nsl
}
bariharmony = \transpose c' a \chordmode {
 \jzchords s1 s d2:maj e:m7
}
barisax = {
 \global
 \set Staff.instrumentName = #"Bari Sax"
 \clef treble
 <<
   \bari
 >>
}

% ------ Trombone ------
tbone = \relative c {
 \Key
 c1 c c
}
tboneharmony = \chordmode {
 \jzchords
}
trombone = {
 \global
 \set Staff.instrumentName = #"Trombone"
 \clef bass
 <<
   \tbone
 >>
}

% ############ Rhythm Section #############

% ------ Guitar ------
gtr = \relative c'' {
 \Key
 R1 * 6
 \sl 
 % A
 \repeat unfold 64 { bes4 bes bes bes }
}
gtrharmony = \chordmode {
 \jzchords
 R1 * 6
 bes2 bes/g c:min7 f:7
 bes bes/g c:min7 f:7
 bes bes:7/d ees e:dim
 bes1/f s1
 bes2 bes/g c:min7 f:7
 bes bes/g c:min7 f:7
 bes bes:7/d ees e:dim
 bes1/f s1

 bes1 bes/g c:min7 f:7

 bes2 bes/g c:min7 f:7
 bes bes/g c:min7 f:7
 bes bes:7/d ees e:dim
 bes1/f s1
}
guitar = {
 \global
 \set Staff.instrumentName = #"Guitar"
 \clef treble
 <<
   \gtr
 >>
}

%% ------ Piano ------
rhUpper = \relative c'' {
 \voiceOne
 \Key
 c1 c c
}
rhLower = \relative c' {
 \voiceTwo
 \Key
 e1 e e
}

lhUpper = \relative c' {
 \voiceOne
 \Key
 g1 g g
}
lhLower = \relative c {
 \voiceTwo
 \Key
 c1 c c
}

PianoRH = {
 \clef treble
 \global
 \set Staff.midiInstrument = "acoustic grand"
 <<
   \new Voice = "one" \rhUpper
   \new Voice = "two" \rhLower
 >>
}
PianoLH = {
 \clef bass
 \global
 \set Staff.midiInstrument = "acoustic grand"
 <<
   \new Voice = "one" \lhUpper
   \new Voice = "two" \lhLower
 >>
}

piano = {
 <<
   \set PianoStaff.instrumentName = #"Piano"
   \new Staff = "upper" \PianoRH
   \new Staff = "lower" \PianoLH
 >>
}

% ------ Bass Guitar ------
Bass = \relative c {
 \Key
 c1 c c
}
bass = {
 \global
 \set Staff.instrumentName = #"Bass"
 \clef bass
 <<
   \Bass
 >>
}

% ------ Drums ------
up = \drummode {
 hh4 <hh sn>4 hh <hh sn> hh <hh sn>4
 hh4 <hh sn>4
 hh4 <hh sn>4
 hh4 <hh sn>4
}

down = \drummode {
 bd4 s bd s bd s bd s bd s bd s
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
     \new Staff = "altosax" \altosax
     \new ChordNames = "barichords" \bariharmony
     \new Staff = "barisax" \barisax
     \new Staff = "trombone" \trombone
   >>

   \new StaffGroup = "rhythm" <<
     \new ChordNames = "chords" \gtrharmony
     \new Staff = "guitar" \guitar
     \new PianoStaff = "piano" \piano
     \new Staff = "bass" \bass
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

 \midi { }
}

