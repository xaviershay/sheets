\version "2.24.4"

% TAB clef with the open-string notes stacked above the staff lines,
% inferred from a stringTuning-style chord (highest string number /
% generally lowest pitch first), and sets Staff.stringTunings to match.
% \labeledTabClef <c, g, c g c' e'>
labeledTabClef =
#(define-music-function (chord) (ly:music?)
   (let* ((ev-chord (car (extract-named-music chord 'EventChord)))
          (pitches (reverse! (event-chord-pitches ev-chord)))
          (note-names #("C" "D" "E" "F" "G" "A" "B"))
          (notes (map (lambda (p) (vector-ref note-names (ly:pitch-notename p))) pitches)))
     #{
       \override Staff.Clef.stencil = #ly:text-interface::print
       \override Staff.Clef.text = \markup {
         \vcenter
           \fontsize #-4
           \override #'(baseline-skip . 1.5)
           \center-column
           #(map (lambda (n) (make-whiteout-markup (make-bold-markup (make-sans-markup n)))) notes)

         % music glyph version
         \vcenter \musicglyph "clefs.tab"
       }
       \set Staff.stringTunings = #pitches
     #}))
