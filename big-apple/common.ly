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
