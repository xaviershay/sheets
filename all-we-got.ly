%{
	babyonboard.ly

%}

\version "2.10.0"
\include "english.ly"

\header
{
	title = "All We Got"
	composer = ""
	tagline = ""
}


global =
{
	\key a \major
	\time 4/4

	% Show bar numbers on every bar
	\override Score.BarNumber #'break-visibility = #end-of-line-invisible
}



%
%	Notes
%


tenorMusic = \relative c''
{
	a4 e d e
  gs e e2
  fs4 e d e
  gs e e2
}


leadMusic = \relative c'
{
	e4 cs b cs
  e cs b2
  e4 cs b cs e cs b( a)

}




baritoneMusic = \relative c'
{
	cs4 a cs a
  b gs gs2
  a4 a fs fs
  b b gs2
}




bassMusic = \relative c
{
	a4 a a a
  gs b e2
  d4 d d d
  cs d e2

}




%
%	Lyrics
%

tenorWords = \lyricmode
{
	" "
}

leadWords = \lyricmode
{
  Love ain't ea -- sy
  Love ait't kind
  Love can't lead you
  Love is blind

  Love will make you lose your mind,
  but love is all we got.
  Love aint _____
  Love ain't true
  Love does things it ought not do, it
  Lies and steals and cheats on you, but
  Love is all we got.
}


baritoneWords = \lyricmode
{
}


bassWords = \lyricmode
{

}




\score {
	\new ChoirStaff
	<<
		\new Staff = upper
		<<
			\clef "G_8"
			\new Voice = "tenor" {
				\voiceOne << \global \tenorMusic >>
			}
			\new Voice = "lead" {
				\voiceTwo << \global \leadMusic >>
			}
		>>

		\new Lyrics \with { alignAboveContext = upper } \lyricsto tenor \tenorWords
		\new Lyrics \lyricsto lead \leadWords


		\new Staff = lower
		<<
			\clef bass
			\new Voice = "baritone" {
				\voiceOne << \global \baritoneMusic >>
			}
			\new Voice = "bass" {
				\voiceTwo << \global \bassMusic >>
			}
		>>

		\new Lyrics \with { alignAboveContext = lower } \lyricsto baritone \baritoneWords
		\new Lyrics \lyricsto bass \bassWords
	>>

	\layout {
		\context {
			% a little smaller so lyrics
			% can be closer to the staff
			\Staff
				\override VerticalAxisGroup #'minimum-Y-extent = #'(-3 . 3)
		}
	}
	\midi{ }
}

\score { \tenorMusic \midi{ } }
\score { \leadMusic \midi{ } }
\score { \baritoneMusic \midi{ } }
\score { \bassMusic \midi{ } }
