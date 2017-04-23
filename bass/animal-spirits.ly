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
  des,4-. r4 r2 |
  c4-. f,-. r2 |
  \set TabStaff.restrainOpenStrings = ##t
  \set TabStaff.minimumFret = #3
  bes4-. ees-. r4 r8. ees16~ |
  ees8. f16~ f g~ g aes~ aes8. ees16 aes,4 |
  \set TabStaff.minimumFret = #1
  des4-. r4 r4 r16 aes-. bes-. b-. |
  c4-. f,-. r2 |
  \set TabStaff.minimumFret = #3
  bes4-. ees-. r4 r8 \deadNote ees16 ees~ |
  ees8. f16~ f g~ g aes~ aes4~ aes16 aes bes des-.|
  r16 \deadNote des, des8 ees f ges8. ges16-. r16 aes bes des-. |
  r16 \deadNote des, des8 ees f ges8 f16 aes16~ aes bes8 des16 |
  bes16 aes des,8 ees f ges8. ges16-. r16 ees f ges~-. |
   \time 2/4
  ges aes8-. bes16~-. bes c8.

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
