\version "2.12.2"
\header {
  title = "Untitled 1"
  composer = "Xavier Shay"
}

upper = {
  \time 3/4
  \key aes \major

  \relative c'' {
    ees8 c aes c ees f |
    ges f des2 |
    <g bes>8 c des2 |
  }
}

lower = {
  \clef bass
  \time 3/4
  \key aes \major

  \relative c' {
    aes4 <c ees> ees, |
    des <f aes> des' |
    ees <ges, bes> ees |
  }
}

dynamics = {}

\score {
  \new PianoStaff <<
    \set PianoStaff.connectArpeggios = ##t
    \override PianoStaff.Arpeggio #'stencil = #ly:arpeggio::brew-chord-bracket
    \new Staff = "upper" \upper
    \new Dynamics = "dynamics" \dynamics
    \new Staff = "lower" \lower
  >>
  \layout { 
    \context {
           \type "Engraver_group"
           \name Dynamics
           \alias Voice % So that \cresc works, for example.
           \consists "Output_property_engraver"
     
           \override VerticalAxisGroup #'minimum-Y-extent = #'(-1 . 1)
           pedalSustainStrings = #'("Ped." "*Ped." "*")
           pedalUnaCordaStrings = #'("una corda" "" "tre corde")
     
           \consists "Piano_pedal_engraver"
           \consists "Script_engraver"
           \consists "Dynamic_engraver"
           \consists "Text_engraver"
     
           \override TextScript #'font-size = #2
           \override TextScript #'font-shape = #'italic
           \override DynamicText #'extra-offset = #'(0 . 2.5)
           \override Hairpin #'extra-offset = #'(0 . 2.5)
     
           \consists "Skip_event_swallow_translator"
     
           \consists "Axis_group_engraver"
         }
  
   \context {
     \PianoStaff
     \accepts Dynamics
     \override VerticalAlignment #'forced-distance = #7
   }
  }
  \midi {
     \context {
       \Score
       tempoWholesPerMinute = #(ly:make-moment 120 4)
     }
   }
}
