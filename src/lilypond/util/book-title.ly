\version "2.24.4"

% Shared title-block layout for scores. Assign the result to
% \paper { bookTitleMarkup = \bookTitleFormat title composer poet }
% Subtitle/subsubtitle/meter/arranger, if present in \header, are picked
% up automatically via \fromproperty.
#(define-markup-command (bookTitleFormat layout props title composer poet)
   (markup? markup? markup?)
   (interpret-markup layout props
     #{
       \markup {
         \override #'(baseline-skip . 3.5)
         \column {
           \fill-line { \fromproperty #'header:dedication }
           \override #'(baseline-skip . 3.5)
           \column {
             \fill-line {
               \huge \larger \larger \bold
               #title
             }
             \fill-line {
               \large \bold
               \fromproperty #'header:subtitle
             }
             \fill-line {
               \smaller \bold
               \fromproperty #'header:subsubtitle
             }
             \fill-line {
               \null
               #composer
               #poet
             }
             \fill-line {
               \fromproperty #'header:meter
               \fromproperty #'header:arranger
             }
           }
         }
       }
     #}))
