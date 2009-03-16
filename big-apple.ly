\version "2.10.10"
\header {
 title = "Big Apple Contest - Draft 2"
 composer = "Solomon Douglas"
 tagline = \markup {
   \column {
     "Transcribed by Xavier Shay"
     "Creative Commons Attribution License"
     "Melbourne, 10th March 2009"
   }
 }
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

  \tempo 4 = 208
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
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes4 r4 |

  R1*7
  r2 r8 bes~ bes bes~ |

  bes8 bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes~ |
  bes bes~ bes4 a8 bes r4 |
  r2 r8 bes8~ bes bes8~ |
  bes8 bes~ bes bes~ bes bes~ bes bes~ |
  bes8 bes~ bes bes~ bes4 r4 |

  \bar "||"

  % B
  \mark \markup { \musicglyph #"scripts.segno" }
  \repeat unfold 3 {
    r2 bes4 -. r4 |
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
  a a a a
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
  \once \override Score.RehearsalMark #'font-size = #4
  \mark \markup { \musicglyph #"scripts.coda" }
  
  bes4 -. r4 r2 |

  \bar "||"

  % C
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

  R1*8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) r8
  bes8 bes8 r4 r g8 bes
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |

  \tiny
  a8^"Solo" fis g a~ a2 |
  r8 fis g a~ a2 |
  f8 d e f~ f d e f~ |
  f2 r |
  e'8 d c bes a g f ees |
  d c bes a \times 2/3 { d ees d } c4 |
  r4 r8 bes' des bes des bes |
  des4. bes8~ bes4 r4 |
  \normalsize

  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) r8 |
  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) r8 |
  bes8 bes8 r4 r g8 bes |
  r8 g8 bes4 f( g8) bes8~ |
  bes4~ bes8 bes~ bes4~ bes8 bes8~ |
  bes4~ bes8 bes~ bes4 r  |
  \bar "||"

  \cadenzaOn 
  \stopStaff
     \once \override TextScript #'word-space = #1.5
        \once \override TextScript #'X-offset = #8
        \once \override TextScript #'Y-offset = #1.5
        | s1*0^\markup { \center-column { "D.S. al Coda" \line { \musicglyph #"scripts.coda" \musicglyph #"scripts.tenuto" \musicglyph #"scripts.coda"} } }
        
        % Increasing the unfold counter will expand the staff-free space
        \repeat unfold 4 {
          s4 s4 s4 s4
          \bar ""
        }
        % Resume bar count and show staff lines again
     \startStaff
   \cadenzaOff
  
  \break
  \once \override Score.RehearsalMark #'extra-offset = #'( -8.42 . 1.75 )
   
 \once \override Score.RehearsalMark #'font-size = #5
 \mark \markup { \musicglyph #"scripts.coda" }
 bes8 -. r r bes -. r4 bes4~\fermata |
 bes1
 \bar "|."
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
   r2 r4 r8 bes'8~ |
   bes8 bes~ bes4 d8 f r4 |
   r2 r4 r8 bes,8~ |
   bes8 bes~ bes4 g8 f r4 |
   r2 r4 r8 bes8~ |
   bes8 bes~ bes4 d8 f r8 bes,8~ |
   bes4~ bes8 bes~ bes4~ bes8 bes8~ |
   bes4~ bes8 bes~ bes4 r  |
 }
 \sl d^"Solo" d d d
 d d d d
 d d d d
 d d d d
 d d d d
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

 R1*8
 \repeat unfold 3 {
   d4( bes8) r d4( bes8) r |
   d8 bes r g f4 g |
 }
 d'4( bes8) r d2 |
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
 }
 \alternative {
   { bes4~ bes8 bes~ bes4 r  | }
   { bes4~ bes8 bes~ bes4 d4~  | }
 }
 \tiny
 d2.^"Solo (Clarinet)" c4
 b a g fis8 f~ |
 f4 f8 g a f e d |
 e f e d g f e d |
 c d e g c4 c |
 c c c8 c r8 f,~\mordent |
 f4 r8 f8~\mordent f4 r8 f8~\mordent |
 f4 r8 f8~\mordent f4 r4 |
 \normalsize

 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

 R1*8
 bes8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) r8 |
 bes,8 bes r bes d f g bes
 r8 g8~ g4 f4( g8 -.) bes,8~ |
 bes4~ bes8 bes~ bes4~ bes8 bes8~ |
 bes4~ bes8 bes~ bes4 r  |

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

 % Coda
 bes2 r4 bes4~\fermata |
 bes1
}
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

 bes8 r r bes r4 \nsl bes,4~\fermata |
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

