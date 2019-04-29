\version "2.18.2"
\header {
  title = "I Believe In You"
  composer = "Larry Graham"
  tagline = \markup { \column { "LilyPond source at https://xaviershay.com/sheets" } }
}

% Props to https://www.youtube.com/watch?v=kVmP_3aeeKg - didn't agree with
% everything but mostly the same.

% Larry Graham solo version at
% http://www.youtube.com/watch?v=3e7EF7rRA9M&t=16m20s
% Contains some extra embellishments not on other recordings (nor here), but
% doesn't include bridge.

global = {
 \time 4/4
}

introMelody = {
  \set TabStaff.minimumFret = #11
  g16^( gis) e d~ d2
  \set TabStaff.minimumFret = #9
  \grace d,16^( b,8) c cis a16 g16^~ g2.
}

introTwoMelody = {
  |
  \set TabStaff.minimumFret = #7
  d,16\rest \grace b,16( cis8.)
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  |

  \set TabStaff.minimumFret = #11
  g16( gis) e d\glissando
  \set TabStaff.minimumFret = #7
  \cadenzaOn
  \hideNotes e, \unHideNotes
  \cadenzaOff
  d,4\rest
  d,2\rest
  |

  \set TabStaff.minimumFret = #7
  d,16\rest \grace b,16( cis8.)
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  |

  \set TabStaff.minimumFret = #6
  d16( cis) b,8\staccato b,\staccato cis8\glissando\staccato
  \cadenzaOn
  \hideNotes e, \unHideNotes
  \cadenzaOff
  d,2\rest
  |

  \set TabStaff.minimumFret = #7
  d,16\rest \grace b,16( cis8.)
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  |

  \set TabStaff.minimumFret = #11
  g16( gis) e d\glissando
  \set TabStaff.minimumFret = #7
  \cadenzaOn
  \hideNotes e, \unHideNotes
  \cadenzaOff
  d,4\rest
  d,2\rest
  |

  \set TabStaff.minimumFret = #7
  d,16\rest \grace b,16( cis8.)
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  e8\staccato
  |

  \set TabStaff.minimumFret = #6
  d16( cis) b,8\staccato b,\staccato cis8\glissando\staccato
  \cadenzaOn
  \hideNotes e, \unHideNotes
  \cadenzaOff
  d,4\rest

  \set TabStaff.minimumFret = #12
  \cadenzaOn
  e,4\glissando
  \hideNotes e,, \unHideNotes
  \cadenzaOff
  \hideNotes d,4\rest \unHideNotes
  |
}

mainRiff = {
  \bar "||"
  \set TabStaff.minimumFret = #2
  \relative {
    \repeat percent 4 {
      e,,8\thumb e\thumb gis\thumb gis\thumb b\thumb b\thumb
      b16\thumb( cis) e8\thumb

      e,8 e gis gis b b
      b16( cis) fis( gis)
    }
  }
  \mark \markup { \musicglyph #"scripts.segno" }
  \repeat volta 2 {
    \relative {
      \repeat percent 4 {
        e,,8\thumb e\thumb gis\thumb gis\thumb b\thumb b\thumb
        b16\thumb( cis) e8\thumb
      }
      |
      \set TabStaff.minimumFret = #4
      \set TabStaff.restrainOpenStrings = ##t

      d8 e fis g
      \set TabStaff.minimumFret = #2
      g, a b g |
    }

    c, c
    \set TabStaff.minimumFret = #5
    d, d e, e
    \set TabStaff.minimumFret = #3
    c, c
    |

    \set TabStaff.restrainOpenStrings = ##t
    \set TabStaff.minimumFret = #5
    a,,16( b,,) b,8\staccato
    a,,16( b,,) b,8\staccato
    a,,16( b,,) b,8\staccato
    a,,16( b,,) b,8\staccato
    |
    b,,4
    d,\rest
    d,2\rest
    \set TabStaff.restrainOpenStrings = ##f

    \set TabStaff.minimumFret = #0
    \relative {
      \repeat percent 4 {
        e,,8\thumb e\thumb gis\thumb gis\thumb b\thumb b\thumb
        b16\thumb( cis) e8\thumb
      }
    }
    \mark \markup { \musicglyph #"scripts.coda" }
  }
}

bridge = {
  \set TabStaff.minimumFret = #7
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,8
  e,,4

  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e8\staccato
  d,4\rest

  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,8
  e,,4

  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  \set TabStaff.minimumFret = #4
  \set TabStaff.restrainOpenStrings = ##t
  gis,,8-> a,,-> ais,,-> b,,->

  \set TabStaff.restrainOpenStrings = ##f
  \set TabStaff.minimumFret = #7
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,8
  e,,4

  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e8\staccato
  d,4\rest

  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,16 e,16
  e,,16 e,,16 e,8
  e,,4

  \set TabStaff.minimumFret = #4
  \set TabStaff.restrainOpenStrings = ##t
  \relative {
    gis,,8-> a-> ais-> b->
    \set TabStaff.minimumFret = #8
    c-> cis-> d-> dis->
  }
  \set TabStaff.restrainOpenStrings = ##f
  \bar "||"
}

coda = {
  \mark \markup { \musicglyph #"scripts.coda" }
  \set TabStaff.minimumFret = #0
  \relative {
    \repeat volta 4 {
      e,,8\thumb^"Vamp to fadeout" e\thumb gis\thumb gis\thumb b\thumb b\thumb
      b16\thumb( cis) e8\thumb
    }
  }
}

\score {
  \new Staff {
    \set Staff.midiInstrument = #"electric bass (finger)"
    <<
      \new Voice = "main" {
        \clef "bass_8"
        \key a \major
        \repeat percent 4 {
          <<
            { \voiceOne \grace e,,16_( e,,1) }
            \new Voice { \voiceTwo
              \introMelody
            } \oneVoice
          >>
        }
        \introTwoMelody
        \mainRiff
        \bridge

        s4^"D.S. al Coda"
      }
      \new TabStaff \with {
        stringTunings = #bass-tuning
      } {
        \repeat percent 4 { \grace e,,16 \introMelody }
        \introTwoMelody
        \mainRiff
        \bridge
        s4
      }
    >>

    <<
      \new Voice = "main" {
        \clef "bass_8"
        \key a \major
        \coda
      }
      \new TabStaff \with {
        stringTunings = #bass-tuning
      } {
        \coda
      }
    >>
  }
  \layout { }
  \midi { \tempo 4 = 90 }
}
