\version "2.24.4"

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
