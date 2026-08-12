\version "2.24.4"

% Small italic label for annotating a staff line, e.g. c4^\markup \instrumentLabel "Lead"
#(define-markup-command (instrumentLabel layout props text) (markup?)
   (interpret-markup layout props
                     (markup #:italic #:fontsize -3 text)))
