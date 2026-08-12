\version "2.24.4"

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

makeOctaves = #(define-music-function (arg mus) (integer? ly:music?)
                 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
