\version "2.19.80"
\header {
  title = "The Muppet Show Theme"
  arranger = "Arranged by Xavier Shay"
  tagline = \markup { \column { "" } }
}

upper = \relative c' {
  \clef "treble_8"
  \key c \major
  \time 2/2
  \tempo "Presto"

  \repeat volta 2 {
    r4 c c a |
    b a8 b r g~ g4 |
    r4 c c a |
    b8 a8 r g~ g2 |
    r4 e e g |
    f e8 f r c'~ c c, |
  }
  \alternative { {
    e4 <c e>8 <c e>~ <c e> <c e> <b g'>4 |
    R1 |
  } {
    e4 <c e>8 <b d>~ <b d> <b d> c4 |
  }}

  r2 \acciaccatura { g''16[a b] } c4 c, |
  \bar "||"
  d c b d |
  c g r c |
  d c b d |
  \override Glissando.style = #'zigzag
  c2\glissando
  \ottava #1
  c''4
  \ottava #0
  c,, |
  d c b d |
  e g, r g |
  a a8 b~ b c d4 |
  r4 \acciaccatura fis,16 g4-. r4 \clef bass \acciaccatura fis,16 g4-- |
  \clef "treble_8"

  r4 c' c a |
  b8 ais b ais b8 g~ g4 |
  r4 c c a |
  b8 bes a aes g2 |
  r4 e e g |
  f e8 f r c'~ c c, |
  e4 e8 e8~ e c e4 |
  a4 a8 a8~ a e a4 |
  c4 c8 c8~ c a c4 |
  e4 e8 e8~ e c e4 |
  <c, f a>2 <c f b> |
  <c f a c> <\parenthesize c f a d> |
  <f a e'> <f a e'> |
  <f b e> <f b e> |
  \repeat tremolo 4 { <c' e g>16 <g a>  }
  << {
    \override Glissando.style = #'zigzag
    g4.\glissando
    \change Staff = "lower"
    g,,,8
  } \\ {
    \change Staff = "upper"
    s4. b'''8\rest
  } >>
  r2
  \ottava #1
  \acciaccatura { g''16[ a b] } c4
  \ottava #0
  r4
  \bar "|."

}

lower = \relative c {
  \key c \major
  \time 2/2

  \repeat volta 2 {
    \clef bass

    c4 <e g> ees <ges a> |
    d <f a> g <b d> |
    \clef treble
    c4 <e g> ees <ges a> |
    d <f a> g, <f' g> |
    c <e g> bes <e g> |
    a, <f' a> aes, <f' aes> |
  }

  \alternative { {
    <a, f' a>8 r8 r8 <aes f' aes> r4 <g f' g> |
    \clef bass
    r4 g, a b |
  } {
    \clef "treble"
    <g' e' g>8 r8 r8 <g d' f> r4 <g c e> |
    \clef bass
    r2 \acciaccatura { g,16 [f e d] } c4 r4 |
  }}

  \bar "||"
  \clef treble
  <f'' a c>4 r <e gis c> r |
  <e g c>
  \clef bass
  g,,4-> c,-> r4 |
  \clef treble
  <f'' a c>4 r <e gis c> r |
  <e g c> r4 r2 |
  <f a c>4 r <e gis c> r |
  <e g c> r4 r2 |
  <f a c>8 r r <fis a c> r4 <g b>4 |
  r2 \acciaccatura fis,16 g4-. r |

  \clef bass
  c,4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c4 <e g> ees <ges a> |
  d <f a> g, <f' g> |
  c <e g> bes <e g> |
  a, <f' a> aes, <f' aes> |
  <g, e' g>8 r r <g e' g>~ <g e' g>2 |
  <fis c' fis>8 r r <fis c' fis>~ <fis c' fis>2 |
  <f a e'>8 r r <f a e'>~ <f a e'>2 |
  <d f d'>8 r r <d f d'>~ <d f d'>2 |

  \clef "bass_8"

  r4 <d, d'>~ <d d'> <d d'>~ |
  <d d'> <d d'>~ <d d'> <d d'>~ |
  <d d'> <d d'>~ <d d'> <d d'>~ |
  <d d'> <g g'>~ <g g'> <g g'> |
  \set tieWaitForNote = ##t
  \repeat tremolo 4 { c,16~ c'~ }
  <c, c'>4. s8 |

  c4 r r2
  \bar "|."
}

dynamics = {
  s1\mf
  s1 * 8
  s2 s4 s4\p |
  s1
  s4 s4\sf s4 s4\p |
  s1 *5
  s4 s4\sf s2

  \override DynamicText.self-alignment-X = #-1.0
  s1\f
  \override DynamicText.self-alignment-X = #0.0
  s1 * 4
  s2 s4 s8 s8\mp \< |
  s1 * 3 |
  s2 s4 s4\fp |
  s1\<
  s1 * 2
  s2 s4 s4\ff
}

#(set-global-staff-size 18)
\score {
  \new PianoStaff <<
     \set PianoStaff.instrumentName = "Piano  "
     \new Staff = "upper" \upper
     \new Dynamics = "dynamics" \dynamics
     \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}

\markup {
  \normalsize { % \teeny \tiny \small \normalsize \large \huge
           % are all viable options here, with \normalsize
           % the default. Pick whatever looks good.
    \fill-line { % This centers the words, which looks nicer
      \hspace #1.0 % gives the fill-line something to work with
      \column {
      \hspace #1.0 % gives the fill-line something to work with
        "It's time to play the music. It's time to light the lights. "
        "It's time to meet the Muppets on the Muppet Show tonight. "
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "It's time to put on makeup. It's time to dress up right."
        "It's time to raise the curtain on the Muppet Show tonight."
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "Why do we always come here? I guess we'll never know."
        "It's like a kind of torture, to have to watch the show."
          \hspace #1.0 % (Basically inserts a blank line; the argument is irrelevant)
        "And now let's get things started. Why don't you get things started?"
        "It's time to get things started on the most sensational, inspirational,"
        "Celebrational, Muppetational - This is what we call the Muppet Show! "
      }
      \hspace #1.0 % gives the fill-line something to work with
    }
  }
}


