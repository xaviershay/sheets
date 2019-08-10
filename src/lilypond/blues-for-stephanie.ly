\version "2.10.10"
\header {
  title = "Blues For Stephanie (WIP)"
  subtitle = "As played by Sandra Lambert"
  arranger = "Transcribed by Xavier Shay"
  tagline = \markup { \column { "" } }
}

harmonies = \chordmode {
  \override ChordName #'font-size = #0.5
  \partial 4 r4 |
  \repeat unfold 3 {
  g1:7 c:7 g:7 s |
  c:7 s1 | g:7 s |
  d:7 c:7 | g:7 s |
  }
}

melody = \relative c' {
  \partial 4 e8 d~ |
  d2 \times 2/3 { r8 d dis } \times 2/3 { e8 g a } |
  \times 2/3 {<e bes'>8. a16 g e } <d a'>8 <c g'> r4 \grace dis8( e8) d~ |
  d4. e8 d4 c8 b~ |
  b2 r4 a'8 g~ |
  g2  \times 2/3 { r8 d dis } \times 2/3 { e8 g a } |
  \grace a8( <e bes'>8) g <d a'> <c g'> r4 \grace dis8( e8) d~ |
  d4. e8 d4 c8 b~ |
  b2 r8 e8 f c'~ |
  c2 r8 d,8 e b'~ |
  b2 r8 d, \grace dis( e8) g\staccato |
  r4 <des' g>2~ <des g>8 g, |
  <c g'>8 g r <bes g'> r4 <g, bes c e>8 <f a b d>~ |

  <f a b d>2 \times 2/3 { r8 d' dis } \times 2/3 { e8 g a } |
  \times 2/3 {<e bes'>8. a16 g e } <d a'>8 <c g'> r4 <g bes c e>8 <f a b d>~ |
  <f a b d>4. <g bes c e>8 <f a b d>4 <g bes c>8 <f a b> |
  r2 \times 2/3 { r4 <b e f a> <b e f a> } |
  <bes d e g>4. <b e f a>8 \times 2/3 { r8 d dis } \times 2/3 { e8 g a } |
  \times 2/3 {<e bes'>8. a16 g e } <d a'>8 <c g'> r4 \grace dis8( e8) d~ |
  d4. e8 d4 c8 b~ |
  b2 r8 e8 f c'~ |
  c2 r4 \grace d,8 e b'~ |
  b2 r8 d, e8 g\staccato |


  r4 \times 2/3 { <des' g>8. des16 c g } \times 2/3 { <c g'>8 g <bes g'> } r8 <d, g>~ |
  \times 2/3 { <d g>8. f16 d cis } \times 2/3 { <c g'>8 g <bes~ g'> } bes4 b8 \mark "Solo" c |

  \bar "||"

  \grace cis8( d) g,~ g b~ \times 2/3 { b8 c16 b g8 } a bes~ |
  \times 2/3 {bes8 c16 bes g8} a8 bes c d dis e |
  fis g g g \times 2/3 {f8. g16 f d } f8 g~ |
  \times 2/3 { g8 f d } f8 g \times 2/3 { r8 a4~ } a8 g |
  \times 2/3 { a8. g16 e g } a8 bes~ \times 2/3 {bes4 a32 g e g } a8 bes~ |
  \times 2/3 {bes4 a32 g e g } a8 bes~ \times 2/3 {bes4 a32 g e g } a8 bes |
  \grace ais( b4) <g g'> <g g'>8 b c cis |

  \grace cis( d4) b8 d r f e c |
  ees4 ees16 c cis d f g bes g aes bes g aes |
  bes des a bes \times 4/5 { aes16 g ges f e } \times 2/3 {ees8 c cis } d8 g, |
  <bes g'>8 <b g'>~ \times 2/3 {<b g'>8. d16 b g } <c g'>8 <c g'>~ \times 2/3 {<c g'>8. d16 c g } |
  <cis g'>8 <cis g'>4. \grace cis8( <d g>) g, a e' |
  d

}
\score {
  <<
    \context ChordNames {
        \set chordChanges = ##t
        \harmonies
    }
    \new Staff = "upper" {
      \melody
    }
  >>
  \layout { 
    indent = #0
  }
  \midi {
    \tempo 4 = 120
  }
}
