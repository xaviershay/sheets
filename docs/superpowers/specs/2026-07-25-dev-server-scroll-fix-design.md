# Fix scroll-reset on bin/dev reload

## Problem

`bin/dev`'s served page uses `<embed src="/out.pdf">` for the PDF viewer.
On every recompile-triggered reload, the client bumps the `src` with a
cache-busting query param (`/out.pdf?t=...`) so the browser refetches
instead of serving a stale cached PDF. But changing `src` on a native
`<embed>`/`<object>` PDF viewer always resets its internal scroll position
to the top of page 1 — there is no cross-browser API to read or restore an
embedded PDF plugin's scroll state. Every save while reviewing page 3 of a
piece jumps back to page 1.

## Root cause

The browser's built-in PDF viewer is an opaque plugin with its own internal
document/scroll state, recreated from scratch whenever `src` changes. There
is no way to preserve state across that recreation using `<embed>`.

## Fix

Stop using the native PDF viewer. Render the PDF ourselves with pdf.js into
a scrollable `<div>` we own, containing one `<canvas>` per page. On reload,
re-render each page's canvas *in place* — the existing canvas elements are
reused (when page count is unchanged, the common case), and the container
`<div>` is never removed or recreated. Because nothing removes the
scrollable element, the browser never touches its `scrollTop`, so the
current scroll position survives a reload. This mirrors how Hacklily's own
viewer avoids the same problem.

This replaces `bin/dev`'s "zero npm dependencies" constraint from the
original design (`docs/superpowers/specs/2026-07-25-dev-server-design.md`)
with "zero *runtime* dependencies" — pdf.js is vendored into the repo as
static files, not installed via npm at runtime, so `bin/dev` still needs
nothing beyond Node itself to run.

## Vendoring pdf.js

Two files from `pdfjs-dist@6.1.200` (Apache-2.0), fetched once and committed
to the repo at `vendor/pdfjs/`:

- `vendor/pdfjs/pdf.min.mjs` (~440KB) — the library, loaded as an ES module.
- `vendor/pdfjs/pdf.worker.min.mjs` (~1.2MB) — the background worker pdf.js
  requires for parsing/rendering off the main thread.

`bin/dev` serves both as static files at `/vendor/pdf.min.mjs` and
`/vendor/pdf.worker.min.mjs`, alongside its existing `/`, `/out.pdf`, and
`/events` routes.

## Client rendering

The served page's `<embed>` is replaced with:

```html
<div id="pdf-pages"></div>
```

styled to scroll (`overflow: auto`, full height). A `<script type="module">`
imports pdf.js from `/vendor/pdf.min.mjs`, points
`pdfjsLib.GlobalWorkerOptions.workerSrc` at `/vendor/pdf.worker.min.mjs`,
and defines a `renderPdf(url)` function:

1. Load the document via `pdfjsLib.getDocument(url).promise`.
2. Reconcile the number of `<canvas>` children in `#pdf-pages` with
   `pdf.numPages` (append/remove canvases at the end as needed — existing
   canvases for unchanged pages are left in place, not recreated).
3. For each page, get it, compute a viewport at a fixed 2x scale (sharper
   than 1x; avoids adding a resize-listener/DPI-detection code path — the
   canvas's backing resolution is fixed, but its CSS width is set to 100%
   so it still displays responsively), and render into that page's canvas.

Called once on initial page load (`renderPdf('/out.pdf')`) and again on
every SSE `reload` event (`renderPdf('/out.pdf?t=' + Date.now())`) — same
cache-busting need as before, just now driving pdf.js's fetch instead of
the embed's.

If the initial load's fetch fails (e.g. no successful compile yet, `/out.pdf`
404s), the rejection is swallowed — the page just shows nothing until the
next successful compile's `reload` event calls `renderPdf` again. This
matches the existing spec's "first compile fails, page shows nothing yet"
behavior.

## Testing (manual)

Run `bin/dev src/lilypond/chameleon.ly`, open the page:

1. Scroll down to a later page (or partway down page 1 for a single-page
   piece), then save an edit → confirm the page reloads with the change and
   the scroll position is unchanged (this is the actual regression test for
   the bug).
2. Confirm the rendered pages still look correct (compare visually against
   what the old `<embed>` rendering looked like, or against the PDF opened
   directly in a standalone viewer).
3. Re-run the existing `bin/dev` manual test scenarios from the original
   spec (edit-and-save reloads, syntax-error keeps last-good PDF, idle
   doesn't reload) to confirm nothing regressed.
