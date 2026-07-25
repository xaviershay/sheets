# Lilypond dev server: auto-compile + no-flicker browser reload

## Problem

Editing a `.ly` file locally requires manually re-running `lilypond` and
manually reloading the PDF in a viewer to see changes. Want a watch-and-serve
loop like Hacklily's online editor, but with a local editor of choice instead
of a browser-based text editor.

A naive "recompile on save, always reload" loop flickers: every save
re-triggers a browser refresh even when the compiled PDF is byte-identical in
substance (e.g. a comment-only edit, or a save that doesn't change engraved
output). Lilypond also embeds a fresh `/CreationDate`, `/ModDate`, an XMP
`DocumentID` UUID, and a `/ID` trailer in every compile, so two compiles of
the *same* source are never byte-identical even though the rendered content
is unchanged — confirmed by compiling `chameleon.ly` twice: 147929 bytes both
times, differing in exactly 8 small byte ranges corresponding to those four
fields. A hash comparison must strip those fields before comparing, or every
save would appear "changed."

## Scope

One new script: `bin/dev-serve <file.ly>`. Not part of the `Build.hs`/Shake
site-build pipeline — this is a standalone local dev tool for iterating on a
single piece.

Out of scope: watching the whole `src/lilypond` tree, a piece picker UI,
integrating into `bin/serve` or the publish flow.

## Architecture

Single Node.js script, no npm dependencies (uses only Node built-ins: `http`,
`fs`, `child_process`, `crypto`). Node is already available on the dev
machine.

Run as: `bin/dev-serve src/lilypond/chameleon.ly`

Listens on a fixed port, `8001` (existing `bin/serve` uses `8000`, so this
stays out of its way if both run at once).

The server:

1. Serves an HTML page at `/` containing a PDF `<embed>` and a small inline
   script.
2. Serves the latest compiled PDF at `/out.pdf`.
3. Serves a Server-Sent Events stream at `/events` for push-based reload
   notification (no polling).
4. Watches the *directory* containing the argument file for `*.ly` changes
   using `fs.watch` (non-recursive). Watching the directory rather than only
   the single argument file covers multi-file pieces such as
   `big-apple/alto.ly`, which `\include`s sibling files like `common.ly` in
   the same directory — editing `common.ly` should also trigger a recompile
   of the target piece.

## Compile + change-detection flow

On a watched-file change event:

1. Debounce 300ms (coalesce rapid successive writes from editor save
   behavior).
2. Run `lilypond -o <tmpdir> <file.ly>`.
3. On non-zero exit: print lilypond's stderr to the terminal running
   `bin/dev-serve`. Do not touch the served PDF. Do not push a reload event.
   The last good PDF keeps being served.
4. On success: read the compiled PDF bytes, canonicalize by stripping the
   volatile fields before hashing:
   - `/CreationDate(D:...)`
   - `/ModDate(D:...)`
   - XMP `xmpMM:DocumentID='uuid:...'`
   - `/ID [<...><...>]` trailer
   via regex over the raw bytes, then SHA-256 the result.
5. Compare to the hash of the currently-served PDF.
   - Same hash: no-op. This is the no-flicker case — no reload event is
     pushed to the browser.
   - Different hash: copy the new PDF to become the served `/out.pdf`, push
     an SSE `reload` event to connected clients.

## Client behavior

The served HTML page holds the PDF in an `<embed>` (or `<object>`) tag and
opens `new EventSource('/events')`. On receiving a `reload` message, it
updates the embed's `src` with a cache-busting query parameter (e.g.
`/out.pdf?t=<timestamp>`) so the browser re-fetches rather than serving from
cache.

## Error handling

- The server process must never exit due to a lilypond compile failure —
  compile errors are expected during normal editing (mid-edit syntax errors)
  and should just be visible in the terminal, not crash the dev loop.
- If the *first* compile (before any successful compile has happened) fails,
  `/out.pdf` 404s until a successful compile occurs; the page shows nothing
  yet. This is acceptable for a dev tool — starting from valid lilypond
  source is the normal case.

## Testing (manual)

Run `bin/dev-serve src/lilypond/chameleon.ly`, open the served page, then:

1. Edit a note, save → confirm the PDF reloads with the change visible.
2. Save the file with no substantive change (e.g. `touch` it, or save
   without editing) → confirm no reload fires (check terminal shows a
   compile ran but no "pushed reload" log line).
3. Introduce a syntax error, save → confirm the old PDF stays displayed and
   the terminal prints lilypond's error.
4. Fix the error, save → confirm reload resumes.
