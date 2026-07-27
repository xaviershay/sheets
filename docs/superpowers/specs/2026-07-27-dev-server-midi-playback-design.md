# Play the generated MIDI from bin/dev

## Problem

`bin/dev` renders the PDF as it's edited, but checking whether the
transcription actually *sounds* right still means opening the `.midi` file
in a separate player. Want playback available directly in the dev server
page, alongside the PDF.

## Fix

### Server (`bin/dev`)

`compile()` already copies the lilypond PDF output to a temp path and
serves it at `/out.pdf`. Do the same for the MIDI output:

- After the existing `fs.copyFileSync(outBase + '.pdf', outPdf)`: if
  `outBase + '.midi'` exists, copy it to a new `outMidi` temp path; if it
  doesn't (not every `.ly` file has a `\midi {}` block), remove any
  stale `outMidi` from a previous compile so `/out.mid` doesn't serve
  audio for a different score.
- New route `GET /out.mid`: serve `outMidi` with
  `Content-Type: audio/midi` if it exists, 404 otherwise. The client
  treats a 404 as "no MIDI for this score", not an error state.

No new SSE event needed — the existing `reload` event (fired on every
successful compile) is the trigger; the client's existing handler for it
grows a line to also refresh the MIDI src.

### Client: persistent header bar

A new fixed bar, full width, pinned to `top: 0` (height ~40px), always
visible, sitting above everything else on the page — including
`#error-banner` and `#warning-banner`, which shift from `top: 0` to
`top: 40px` (below the new bar) so nothing overlaps.

Contains a single [`<midi-player>`](https://github.com/cifkao/html-midi-player)
element (its stock UI — play/pause, scrubber, elapsed time; no
visualizer). The library (tone.js + magenta + html-midi-player, combined
jsdelivr bundle) loads via one CDN `<script>` tag. Audio samples
(`sgm_plus` soundfont, includes GM percussion for the drum parts) are
fetched by the player itself from Google's soundfont CDN at playback
time — both are network dependencies accepted for now; no offline
story is being built for MIDI.

On the `reload` SSE event, alongside the existing PDF re-render: set
`midi-player.src = '/out.mid?t=' + Date.now()` and call `.stop()` if it
was playing. Playback never auto-starts — a reload happens on every
keystroke-triggered recompile while editing, so autoplay would fire
constantly. If `/out.mid` 404s, hide the player and show a plain
"no MIDI for this score" label in the bar instead.

### Graceful offline fallback

The whole feature must degrade cleanly if the CDN is unreachable — PDF
viewing and the error/warning banners must keep working regardless.

- The player `<script>` tag gets an `onerror` handler for the outright
  network-failure case.
- Separately, after the script's load/error fires, check
  `customElements.get('midi-player')` is actually defined before wiring
  up any player logic — covers the script loading but failing
  internally (e.g. a bundle-internal error that doesn't trigger the
  `<script>` tag's own `onerror`).
- Either failure path swaps the header bar's contents to a plain
  disabled-looking `"MIDI unavailable (offline)"` label instead of a
  broken/blank custom element.

## Testing (manual)

Run `bin/dev` against `src/lilypond/nothing-breaks.ly` (has a
`\midi {}` block):

1. Header bar appears with a working play button; playback includes
   drums.
2. Edit the file while playing → recompile fires → playback stops and
   the player loads the newly generated MIDI (confirm by editing a note
   and hearing the change on replay).

Run `bin/dev` against a `.ly` file with no `\midi {}` block (e.g.
something in `src/lilypond/wip/`):

3. `/out.mid` 404s cleanly; bar shows "no MIDI for this score" instead
   of a broken player; PDF viewing still works.

Simulate the CDN being unreachable (e.g. block the jsdelivr/googleapis
hosts):

4. Bar shows "MIDI unavailable (offline)"; PDF viewing and the
   error/warning banners still work normally.
