\version "2.10.10"
\header {
 title = "Big Apple Contest"
 composer = "Solomon Douglas"
 tagline = \markup {
   \column {
     "Transcribed by Xavier Shay"
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
  \set Score.skipBars = ##t

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

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r4 r8 bes,8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r |

  R1*3
  r2 r8 bes'~ bes bes~ |

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r4 r8 bes,8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r |

  \bar "||"
  % B
  \repeat unfold 3 {
    r2 bes'4 -. r4 |
    r4 r8 bes8 -. r2 |
    r8 bes8 -. r4 r2 |
    bes4 -. r4 r4 bes -. |
  }
  r2 bes4 -. r4 |
  r4 r8 bes8 -. r2 |
  r8 bes8 -. r4 r2 |
  bes4 -. r4 r2 |

  \sl
  a4^"Solo" a a a
  a a a a
  a a a a
  a a a a
  \nsl

  \repeat unfold 1 {
    r2 bes4 -. r4 |
    r4 r8 bes8 -. r2 |
    r8 bes8 -. r4 r2 |
    bes4 -. r4 r4 bes -. |
  }
  r2 bes4 -. r4 |
  r4 r8 bes8 -. r2 |
  r8 bes8 -. r4 r2 |
  bes4 -. r4 r2 |

  \bar "||"

  \repeat unfold 2 {
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) r8
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) r8
    bes8 bes8 r4 r g8 bes
    r8 g8 bes4 f( g8) bes8~ |
    bes4~ bes8 bes~ bes4~ bes8 bes8~ |
    bes4~ bes8 bes~ bes4 r  |
  }

  R1*4
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |

  \sl
  a4^"Solo" a a a
  a a a a
  a a a a
  a a a a
  \nsl

  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |

  \bar "||"
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
 \sl d'^"Solo" d d d
 d d d d
 d d d d
 d d
 \nsl
 r2

 r2 r4 r8 bes8~ |
 bes8 bes~ bes4 d8 f r4 |
 r2 r4 r8 bes,8~ |
 bes8 bes~ bes4 g8 f r4 |
 r2 r4 r8 bes8~ |
 bes8 bes~ bes4 d8 f r8 bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

 % B
 \repeat unfold 3 {
   d4( bes8) r d4( bes8) r |
   d8 bes r g f4 g |
 }
 d'4( bes8) r d4. bes8~ |
 bes2 r2 |
 \repeat unfold 3 {
   d4( bes8) r d4( bes8) r |
   d8 bes r g f4 g |
 }
 d'4( bes8) r d4. bes8~ |
 bes2 r2 |

 R1*4
 \repeat unfold 3 {
   d4( bes8) r d4( bes8) r |
   d8 bes r g f4 g |
 }
 d'4( bes8) r d4. bes8~ |
 bes2 r2 |

 % C
 \repeat unfold 2 {
   bes8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) r8 |
   bes,8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) r8 |
   bes,8 bes r bes d f g bes
   r8 g8~ g4 f4( g8 -.) bes,8~ |
   bes4~ bes8 bes~ bes4~ bes8 bes8~ |
   bes4~ bes8 bes~ bes4 r  |
 }
 \sl d^"Solo (Clarinet)" d d d
 d d d d
 d d d d
 d d
 \nsl
 r2
 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

 R1*4
 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |
 
}
altoharmony = \transpose c' a \chordmode {
 \jzchords
 s1 * 6
 s1 * 8
 bes1 bes/g c:min7 f:7


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

% ############ Rhythm Section #############

% ------ Guitar ------
gtr = \relative c'' {
 \Key
\set Score.skipBars = ##t
 R1 * 6
 \sl 
 % A
 \repeat unfold 28 { bes4 bes bes bes }

 % B
 \repeat unfold 28 { bes4 bes bes bes }

 % C
 \repeat unfold 28 { bes4 bes bes bes }
 \repeat unfold 12 { bes4 bes bes bes }
}
gtrharmony = \chordmode {
 \jzchords
 R1 * 6
 \repeat unfold 3 {
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

 \repeat unfold 4 { \jazzRide }
 \repeat unfold 8 { \jazzHats }

 \repeat unfold 28 { \jazzRide }

 \repeat unfold 28 { \jazzHats }
 \repeat unfold 12 { \jazzHats }
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
       tempoWholesPerMinute = #(ly:make-moment 220 4)
     }
 }
}

