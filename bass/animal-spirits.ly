\version "2.18.2"
\header {
  title = "Animal Spirits"
  composer = "Vulfpeck"
  tagline = \markup { \column { "LilyPond source at https://github.com/xaviershay/sheets" } }
}

global = {
 \time 4/4
}


intro = {
  \relative c, {

  \set TabStaff.minimumFret = #11
  r1 r2 r4
  \afterGrace des'4\glissando {
  \stemDown \hideNotes
  aes16 }
  \unHideNotes
  \set TabStaff.minimumFret = #1
  \bar "||"
  des,4 r4 r2 |
  c4 f, r2 |
  \set TabStaff.restrainOpenStrings = ##t
  \set TabStaff.minimumFret = #3
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f g~ g aes~ aes8. ees16 aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 aes( bes b |
  c4) f, r2 |
  \set TabStaff.minimumFret = #3
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f g~ g aes~ aes4~ aes16 aes bes des-.|
  \bar "||"

  r16 \deadNote des, des8 ees f ges8. ges16-. r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
   \time 2/4
  ges aes8 bes16~ bes c8.

  \bar "||"
  \time 4/4
  \set TabStaff.minimumFret = #1
  des,4^\markup { \italic "This is a true love story song..." } r4 r2 |
  c4 f, r2 |
  \set TabStaff.restrainOpenStrings = ##t
  \set TabStaff.minimumFret = #3
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f g~ g aes~ aes8. ees16 aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 aes bes b |
  c4 f,
  \set TabStaff.minimumFret = #5
  r4. a16 bes |
  \set TabStaff.minimumFret = #4
  bes4 ees r4 bes16 des ees des |
  ees8. f16~ f g~ g aes~ aes4~ aes16 aes bes des-.|

  % Chorus
  \bar "||"
  \set TabStaff.minimumFret = #3
  r16 \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~ des8 des8 des16 aes16 bes des-. |

  r16 \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~
  \afterGrace des2\glissando {
  \stemDown \hideNotes
  aes16 }
  \unHideNotes
  \bar "||"

  \set TabStaff.minimumFret = #1
  des,4^\markup { \italic "Now everyone is well aware..." } r4 r4 r16 aes bes b |
  c4 f, r4 r8

  \set TabStaff.minimumFret = #5
  c'16 b |
  \set TabStaff.minimumFret = #3
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f g~ g aes~ aes8. ees16 aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 f,8. |
  c'8 f,16 f r4 r4 r8
  \set TabStaff.minimumFret = #5
  bes16 a|
  bes4 ees r4 r8. bes16 |
  \set TabStaff.minimumFret = #3
  ees8. f16~ f g~ g aes~ aes4~ aes16 aes bes des-.|

  % Chorus
  \bar "||"
  \set TabStaff.minimumFret = #3
  r16 \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~ des16 aes des8 des16 aes16 bes des-. |

  r16 \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~ des4 c |
  bes8 bes bes bes16 f bes4 r4 |
  \bar "||"
  ees,4^\markup { \italic "And when the rising action rises..." }  f ges g8. aes16~ |
  aes4~ aes16 ees8 aes,16~ aes8. ees'16 aes16 ges8. |
  ees4 f ges bes | aes16 aes8 aes16 r16 aes8 aes16 aes4-. r4 |
  \bar "||"
  }
}

<<
  \new Voice = "main" {
    \clef "bass_8"
    \key aes \major
    \intro
  }
  \new TabStaff \with {
    stringTunings = #bass-tuning
  } {
    \override Glissando.minimum-length = #3
    \override Glissando.springs-and-rods =
                        #ly:spanner::set-spacing-rods
    \override Glissando.thickness = #2
    \intro
  }
>>
