# Nothing Breaks: split into two StaffGroups (tried, reverted)

Explored splitting `nothing-breaks.ly`'s single flat list of staves into
two `\new StaffGroup`s with a genuine musical handoff: Pad+Piano bracketed
together for the intro, then Lead+Drums bracketed together for the rest of
the piece, with the first group's staves gone entirely by the time the
second group enters (not just visually bracketed — a real "these
instruments finish, then those start").

**Decision: not using it for now.** This documents what was tried and what
was learned, so it can be picked up again later without repeating the
discovery work. The diff itself was reverted; nothing landed.

## What it took

### 1. The StaffGroup wrapping itself

Straightforward — wrap `\pad`/`\piano` in one `\new StaffGroup <<...>>`,
`\synth`/`\new DrumStaff` in another, inside the top-level `\score { << ... >> }`.

### 2. Making empty staves actually disappear from bar 1

`\RemoveEmptyStaves` was already in the `\layout` block, but staves that
are empty *for the entire first system* are kept visible by default
anyway — LilyPond's `VerticalAxisGroup.remove-first` grob property
defaults to `##f` specifically so a score shows its full instrumentation
up front. Needed an explicit override to turn that off:

```lilypond
\context {
  \Staff
  \RemoveEmptyStaves
  \override VerticalAxisGroup.remove-first = ##t
}
```

**Gotcha:** `DrumStaff` is a distinct context type from `Staff` in
LilyPond's translator hierarchy — it does not inherit `\Staff`'s context
overrides. Needed the identical block again, targeted at `\DrumStaff`,
or the drum staff stayed visible (empty) through the intro while the Lead
staff correctly vanished.

Once both overrides were in place, Pad+Piano's `StaffGroup` correctly
dropped out of the systems from bar 9 onward (an existing fermata/rest bar
already shared by every part — the piece already had a natural gap there,
nothing needed to change musically), and Lead+Drums correctly stayed
hidden until they start at bar 10.

### 3. Getting instrument labels to reappear at the handoff

With the staves hidden until they start, nothing printed "Lead" or
"Drums" anywhere — LilyPond only auto-prints `instrumentName` (the long
name) on the score's literal first system, and `shortInstrumentName` on
every *other* system. Undefined `shortInstrumentName` = blank forever.

First attempt: set `shortInstrumentName = "Lead"` / `"Drums"` in each
staff's `\with` block. This worked for getting the label to show at the
reentry point, but — because `short-indent` is a single global `\paper`
value applied uniformly to every non-first system in the whole score —
it also repeated the label on *every subsequent system*, and reserved
the same left-margin width on every one of those systems whether or not
text was actually printed there. Not what was wanted here.

Also hit: the auto-computed `short-indent` margin was too narrow and
clipped "Drums" at the page edge (only "ums" rendered). Fixed at the time
with an explicit `\paper { short-indent = 1.5\cm }`, but this was only a
workaround for the repeating-label approach and was removed again once
that approach was abandoned.

**What actually worked cleanly:** skip the `instrumentName`/
`shortInstrumentName` auto-print mechanism entirely for the reentry label.
Instead, attach a one-off `^\markup` directly to the first reentry note,
reusing the `instrumentLabel` markup command already in the file (the
same one used for the "Vox & Strings" / "Strings" annotations on the Pad
part):

```lilypond
f4^\markup \instrumentLabel "Lead" e8 d c2 |
```
```lilypond
cymc4^\markup \instrumentLabel "Drums" cymc4 cymc4 cymc4 |
```

This prints exactly once, right where the part enters, with no left-margin
indent reserved anywhere — because it's just a text annotation, not the
formal instrument-name engraver mechanism. `instrumentName` was kept in
each `\with` block (harmless, and it's also what LilyPond uses to name
MIDI tracks), but `shortInstrumentName` and the `\paper` override were
both removed once this approach replaced them.

## Full diff as tried (for reference)

```diff
diff --git a/src/lilypond/nothing-breaks.ly b/src/lilypond/nothing-breaks.ly
index d6a40b4..6e6d802 100644
--- a/src/lilypond/nothing-breaks.ly
+++ b/src/lilypond/nothing-breaks.ly
@@ -78,7 +78,7 @@ synth = \new Staff \with { instrumentName = "Lead" midiInstrument = "lead 2 (saw
     R1 \fermata
     \bar "||"
 
-    f4 e8 d c2 |
+    f4^\markup \instrumentLabel "Lead" e8 d c2 |
     r2 a4 c |
     d4. e8 e2 |
     g4 f8 ees c4. c8~ |
@@ -157,7 +157,7 @@ drh = \drummode {
   R1*8 |
   s1 |
   \bar "||"
-  cymc4 cymc4 cymc4 cymc4 |
+  cymc4^\markup \instrumentLabel "Drums" cymc4 cymc4 cymc4 |
   cymc4 cymc4 cymc4 cymc4 |
   cymcb2 cymc2 |
   s2 s4. cymcb8 |
@@ -213,21 +213,31 @@ drl = \drummode {
 \score {
   <<
     \padChords
-    \pad
-    \piano
-    \synth
-    \new DrumStaff \with { instrumentName = "Drums" drumStyleTable = #drumStyleTable } {
-      <<
-        \new DrumVoice { \stemUp \drh }
-        \new DrumVoice { \stemDown \drl }
-      >>
-    }
+    \new StaffGroup <<
+      \pad
+      \piano
+    >>
+    \new StaffGroup <<
+      \synth
+      \new DrumStaff \with { instrumentName = "Drums" drumStyleTable = #drumStyleTable } {
+        <<
+          \new DrumVoice { \stemUp \drh }
+          \new DrumVoice { \stemDown \drl }
+        >>
+      }
+    >>
   >>
 
   \layout {
     \context {
       \Staff
       \RemoveEmptyStaves
+      \override VerticalAxisGroup.remove-first = ##t
+    }
+    \context {
+      \DrumStaff
+      \RemoveEmptyStaves
+      \override VerticalAxisGroup.remove-first = ##t
     }
   }
   \midi {}
```

## If picked up again

The markup-annotation approach (last section above) is the one worth
starting from — it's the only one of the three that satisfied "label
shows once, at the right time, no layout side effects." The StaffGroup
wrapping and the two `remove-first` overrides are straightforward and
not really in question; the only genuinely fiddly part was the label
timing, and that's solved.
