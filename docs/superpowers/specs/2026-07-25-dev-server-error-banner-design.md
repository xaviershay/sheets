# Surface lilypond compile errors in the browser

## Problem

`bin/dev` currently only prints lilypond compile failures to the terminal
running the server. The browser gives no indication anything went wrong —
you have to alt-tab to the terminal to see why the PDF didn't update. Want
the error surfaced in the browser itself, without disturbing the currently
displayed PDF or its scroll position (so when the error is fixed, you're
still where you were).

## Fix

Add a second SSE event type, `error`, mirroring the existing `reload`
event:

- Server: `compile()`'s existing failure branch (`bin/dev` — currently just
  `console.error('lilypond failed:\n' + stderr)`) additionally calls a new
  `pushError(stderr)`, sending `event: error\ndata: <JSON-encoded
  stderr>\n\n` to all connected SSE clients. JSON-encoding is necessary
  because SSE `data:` fields can't contain raw newlines the way multi-line
  lilypond stderr does.
- Client: a fixed-position banner element, hidden by default, shown with
  the error text on an `error` SSE event, hidden again on the next `reload`
  SSE event (a successful compile). The banner sits on top of the existing
  `#pdf-pages` div (`position: fixed`) — it never touches `#pdf-pages` or
  its canvases, so the scroll position already preserved by the prior fix
  (`2026-07-25-dev-server-scroll-fix-design.md`) is unaffected by showing or
  hiding it.

## Banner content and styling

Full lilypond stderr text (not a summary), monospace, in a `<pre>` so
whitespace/line breaks are preserved as lilypond emitted them. Red/dark
background so it reads clearly as an error state. Capped at a reasonable
max-height (e.g. 40% of viewport) with its own `overflow: auto`, since
lilypond errors can be long — the banner scrolling internally, independent
of `#pdf-pages`'s scroll position.

## Testing (manual)

Run `bin/dev`, open the page:

1. Introduce a syntax error, save → confirm the banner appears with the
   lilypond error text, and the PDF underneath (and its scroll position)
   is untouched.
2. Fix the error, save → confirm the banner disappears and the PDF
   reloads normally.
3. Scroll down before triggering an error, confirm the error banner
   appearing/disappearing never moves the scroll position (this is the
   point of the feature).
