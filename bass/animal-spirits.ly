\version "2.18.2"
\header {
  title = "Animal Spirits"
  composer = "Vulfpeck"
  arranger = "Transcribed by Xavier Shay"
  piece = "Electric Bass"
  tagline = \markup { \column { "LilyPond source at https://github.com/xaviershay/sheets" } }
}

global = {
 \time 4/4
}


song = {
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
  \set TabStaff.minimumFret = #5
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f ges~ ges aes~ aes8. ees16
  \set TabStaff.minimumFret = #4
  aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 aes bes b |
  c4 f, r2 |
  \set TabStaff.minimumFret = #5
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f ges~ ges aes~ aes4~ aes16 aes bes des-.|
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
  \set TabStaff.minimumFret = #5
  bes4 ees r4 r8. bes16 |
  ees8. f16~ f ges~ ges aes~ aes8. ees16
  \set TabStaff.minimumFret = #4
  aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 aes bes b |
  c4 f,
  \set TabStaff.minimumFret = #5
  r4. a16 bes |
  \set TabStaff.minimumFret = #5
  bes4 ees r4 bes16 des ees des |
  ees8. f16~ f ges~ ges aes~ aes4~ aes16 aes bes des-.|

  % Chorus
  \bar "||"
  \set TabStaff.minimumFret = #5
  r16^\markup { \italic "Chorus!" } \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
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
  des,4^\markup { \italic "Now everyone seems unaware..." } r4 r4 r16 aes bes b |
  c4 f, r4 r8

  \set TabStaff.minimumFret = #5
  c'16 b |
  \set TabStaff.minimumFret = #3
  bes4 ees r4 r8. bes16 |
  \set TabStaff.minimumFret = #5
  ees8. f16~ f ges~ ges aes~ aes8. ees16
  \set TabStaff.minimumFret = #4
  aes,4 |
  \set TabStaff.minimumFret = #1
  des4 r4 r4 r16 f,8. |
  c'8 f,16 f r4 r4 r8
  \set TabStaff.minimumFret = #5
  bes16 a|
  bes4 ees r4 r8. bes16 |
  \set TabStaff.minimumFret = #5
  ees8. f16~ f ges~ ges aes~ aes4~ aes16 aes bes des-.|

  % Chorus
  \bar "||"
  \set TabStaff.minimumFret = #5
  r16^\markup { \italic "Chorus!" } \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~ des16 aes des8 des16 aes16 bes des-. |

  r16 \deadNote des, des8 ees f ges8. ges16 r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16 r16 ees f ges~ |
  ges aes8 bes16~ bes c8 des16~ des4 c |
  bes8 bes bes bes16 f bes4 r4 |
  \bar "||"
  \set TabStaff.minimumFret = #3
  ees,4^\markup { \italic "And when the rising action rises..." }  f ges g8. aes16~ |
  aes4~ aes16 ees8 aes,16~ aes8. ees'16 aes16 ges8. |
  ees4 f ges bes | aes16 aes8 aes16 r16 aes8 aes16 aes4-. r4 |
  \bar "||"

  \compressFullBarRests
  R1*4
  %\clef "bass"
  \ottava #1
  \set TabStaff.minimumFret = #15
  r16 aes'16 bes aes des bes aes des,~
  des aes'16 bes aes des bes aes des,~ |
  des aes'16 bes aes des bes aes des,~
  des f8 aes16~ aes16 bes8 des,16~ |
  des aes'16 bes aes des bes aes des,~
  des aes'16 bes aes des bes aes ges~ |
  \time 2/4
  ges16 aes8 bes16~ bes c8 ges16~ | ges aes8 bes16~ bes c8

  \set TabStaff.minimumFret = #7
  ges,16~ |
  ges16 aes8 bes16~ bes c8 des16~ |
  \time 4/4
  \afterGrace des2.\glissando {
  \stemDown \hideNotes
  aes16 }
  \unHideNotes
  \set TabStaff.minimumFret = #1
  \ottava #0

  r8.^\markup { \italic "   2, 3, 4 ..." }

  % \clef "bass_8"
  des,16~

  \bar "||"

  des4 c8 f, bes4 ees8. aes,16~ |
  aes4
  \set TabStaff.minimumFret = #6
  r8. ees'16 aes16\glissando bes16\glissando aes8~
  \afterGrace aes8.\glissando {
  \stemDown \hideNotes
  ees16
  \unHideNotes
  }
  \set TabStaff.minimumFret = #1
  des16~
  |
  des4 c8 f, bes4 ees8. aes,16 |
  r8. aes16~ aes8. aes16~ aes16 aes8 \deadNote aes16 aes8. des16~ |
  des4 c8 f, bes4 ees8. aes,16~ |
  aes 4
  \set TabStaff.minimumFret = #4
  r8. ees'16 \acciaccatura aes8\glissando bes8 aes,8 aes'8. des,16~ |
  \set TabStaff.minimumFret = #1
  des4 c8 f, bes4 ees8. aes,16 |
  r8. aes16~ aes8. aes16~ aes16 aes8 \deadNote aes16 aes8. des16~ |
  des4 c8 f, bes4 ees8. aes,16~ |

  \set TabStaff.minimumFret = #6
  aes4 r16 ees'16 aes16\glissando bes16\glissando aes8. \deadNote ees16
  \set TabStaff.minimumFret = #1
  aes,16 bes des8~ |
  des4 c8 f, bes4 ees8. aes,16 |
  r8. aes16~ aes8. aes16~ aes16 aes8 \deadNote aes16 aes8. des16~ |
  \afterGrace des4\glissando {
  \hideNotes aes'16 \unHideNotes
  }
  \set TabStaff.minimumFret = #7
  c8 f, bes4~ \afterGrace bes8.\glissando {
  \hideNotes f16 \unHideNotes
  }
  \set TabStaff.minimumFret = #1
  f,16~ |
  f16 aes8.
  \set TabStaff.minimumFret = #4
  r16 ees'16 aes16\glissando bes16\glissando aes4~ aes16
  \set TabStaff.minimumFret = #1
  aes,8 des16~ |
  des4^\markup { \italic "Fade out" } c8 f, bes4 ees8. aes,16 |
  r8. aes16~ aes8. aes16~ aes16 aes8 \deadNote aes16 aes8. des16 |
  R1*4
  \bar "|."
  }
}

<<
  \new Voice = "main" {
    \key des \major
    \clef "bass_8"
    \song
  }
  \new TabStaff \with {
    stringTunings = #bass-tuning
  } {
    \override Glissando.minimum-length = #3
    \override Glissando.springs-and-rods =
                        #ly:spanner::set-spacing-rods
    \override Glissando.thickness = #2
    \song
  }
>>
