# bin/dev Scroll-Reset Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Stop `bin/dev`'s reload from resetting the PDF viewer's scroll position, by replacing the native `<embed>` PDF viewer with a pdf.js-rendered canvas-per-page view inside a `<div>` that's never recreated across reloads.

**Architecture:** Vendor pdf.js's two build files into the repo and serve them as static routes from the existing `bin/dev` HTTP server. Replace the served page's `<embed>` with a scrollable `<div>` containing one `<canvas>` per page, rendered client-side via pdf.js. Reload re-renders the same canvas elements in place rather than swapping a `src` attribute, so the scrollable container — and therefore its scroll position — is untouched.

**Tech Stack:** Node.js built-ins (unchanged), pdf.js 6.1.200 (vendored, Apache-2.0), Canvas 2D (browser-side).

## Global Constraints

- No new *runtime* dependencies for `bin/dev` itself — pdf.js is vendored as static files at `vendor/pdfjs/`, not installed via npm. (Spec: Fix)
- Vendor files: `vendor/pdfjs/pdf.min.mjs` and `vendor/pdfjs/pdf.worker.min.mjs`, from `pdfjs-dist@6.1.200`. Already fetched into the working tree, not yet committed. (Spec: Vendoring pdf.js)
- Fixed port 8001, existing `/`, `/out.pdf`, `/events` routes unchanged in behavior — this plan only adds routes and changes what `/` serves. (Existing spec: `2026-07-25-dev-server-design.md`)
- Canvas render scale: fixed 2x, canvas CSS width 100% for responsive display — no resize-listener/DPI-detection code. (Spec: Client rendering)
- `renderPdf` reconciles canvas count with page count (append/remove at the end) rather than clearing and rebuilding the container, so unchanged pages' canvases — and the container's scroll position — are left alone. (Spec: Fix)

---

## File Structure

- Add (already fetched, uncommitted): `vendor/pdfjs/pdf.min.mjs`, `vendor/pdfjs/pdf.worker.min.mjs`.
- Modify: `bin/dev` — two new static routes, and `PAGE_HTML` replaces `<embed>` with the pdf.js canvas viewer.

---

### Task 1: Vendor pdf.js and serve it

**Files:**
- Add: `vendor/pdfjs/pdf.min.mjs`, `vendor/pdfjs/pdf.worker.min.mjs` (already present in the working tree from the brainstorming step, just need committing).
- Modify: `bin/dev`

**Interfaces:**
- Produces: `/vendor/pdf.min.mjs` and `/vendor/pdf.worker.min.mjs` HTTP routes, serving the two vendored files with `Content-Type: text/javascript`. Task 2's client script depends on both being reachable at those URLs.

- [ ] **Step 1: Add vendor file paths and the two routes**

In `bin/dev`, add near the other path constants:

```javascript
const vendorPdfJs = path.join(__dirname, '..', 'vendor', 'pdfjs', 'pdf.min.mjs');
const vendorPdfWorker = path.join(__dirname, '..', 'vendor', 'pdfjs', 'pdf.worker.min.mjs');
```

In the `http.createServer` handler, add two branches (before the final `else` 404):

```javascript
  } else if (req.url === '/vendor/pdf.min.mjs') {
    res.writeHead(200, { 'Content-Type': 'text/javascript' });
    fs.createReadStream(vendorPdfJs).pipe(res);
  } else if (req.url === '/vendor/pdf.worker.min.mjs') {
    res.writeHead(200, { 'Content-Type': 'text/javascript' });
    fs.createReadStream(vendorPdfWorker).pipe(res);
```

- [ ] **Step 2: Run and verify both routes serve**

Run: `node --check bin/dev` — expect no output (valid syntax).

Run: `bin/dev src/lilypond/chameleon.ly` in the background, then:

```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/vendor/pdf.min.mjs
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/vendor/pdf.worker.min.mjs
curl -s http://localhost:8001/vendor/pdf.min.mjs | head -c 40
```

Expected: both `200`, and the last command's output starts with a JS comment (`/**` license header).

Stop the server before continuing.

- [ ] **Step 3: Commit**

```bash
git add vendor/pdfjs/pdf.min.mjs vendor/pdfjs/pdf.worker.min.mjs bin/dev
git commit -m "Vendor pdf.js and serve it from bin/dev"
```

---

### Task 2: Replace the embed with a scroll-preserving pdf.js canvas viewer

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `/vendor/pdf.min.mjs`, `/vendor/pdf.worker.min.mjs` (Task 1), existing `/out.pdf` and `/events` routes (unchanged).
- Produces: fully working scroll-preserving viewer — this is the last task, and the fix the whole plan exists for.

- [ ] **Step 1: Replace `PAGE_HTML`**

Change:

```javascript
const PAGE_HTML = `<!doctype html>
<html>
<head><meta charset="utf-8"><title>dev: ${targetBase}</title>
<style>html,body{margin:0;height:100%} embed{width:100%;height:100%;border:0}</style>
</head>
<body>
<embed id="pdf" src="/out.pdf" type="application/pdf">
<script>
  const es = new EventSource('/events');
  es.addEventListener('reload', () => {
    document.getElementById('pdf').src = '/out.pdf?t=' + Date.now();
  });
</script>
</body>
</html>`;
```

to:

```javascript
const PAGE_HTML = `<!doctype html>
<html>
<head><meta charset="utf-8"><title>dev: ${targetBase}</title>
<style>
  html,body{margin:0;height:100%}
  #pdf-pages{width:100%;height:100%;overflow:auto;background:#525659}
  #pdf-pages canvas{display:block;margin:0 auto 8px;box-shadow:0 0 4px rgba(0,0,0,0.5)}
</style>
</head>
<body>
<div id="pdf-pages"></div>
<script type="module">
  import * as pdfjsLib from '/vendor/pdf.min.mjs';
  pdfjsLib.GlobalWorkerOptions.workerSrc = '/vendor/pdf.worker.min.mjs';

  const container = document.getElementById('pdf-pages');

  async function renderPdf(url) {
    const pdf = await pdfjsLib.getDocument({ url }).promise;
    while (container.children.length < pdf.numPages) container.appendChild(document.createElement('canvas'));
    while (container.children.length > pdf.numPages) container.lastChild.remove();
    for (let i = 1; i <= pdf.numPages; i++) {
      const page = await pdf.getPage(i);
      const viewport = page.getViewport({ scale: 2 });
      const canvas = container.children[i - 1];
      canvas.width = viewport.width;
      canvas.height = viewport.height;
      canvas.style.width = '100%';
      const ctx = canvas.getContext('2d');
      await page.render({ canvasContext: ctx, viewport }).promise;
    }
  }

  renderPdf('/out.pdf').catch(() => {});

  const es = new EventSource('/events');
  es.addEventListener('reload', () => {
    renderPdf('/out.pdf?t=' + Date.now());
  });
</script>
</body>
</html>`;
```

- [ ] **Step 2: Syntax-check and confirm the server still starts**

Run: `node --check bin/dev` — expect no output.

Run: `bin/dev src/lilypond/chameleon.ly` in the background, then:

```bash
curl -s http://localhost:8001/ | grep -o "id=\"pdf-pages\""
curl -s http://localhost:8001/ | grep -o "type=\"module\""
```

Expected: both greps find a match, confirming the new page markup is served.

Stop the server before continuing.

- [ ] **Step 3: Full manual verification in a browser — this is the actual regression test**

Run: `bin/dev src/lilypond/chameleon.ly`, open `http://localhost:8001/` in a browser.

1. Confirm the PDF renders (pages visible on a gray background, matching the piece's content).
2. Scroll down (or, for a single-page piece, scroll partway down the page). Edit a note in `src/lilypond/chameleon.ly` and save.
3. Confirm: the page reloads with the edit reflected, **and the scroll position is unchanged** — this is the bug this plan fixes. Compare against the old behavior (jumping back to the top) to confirm it's actually different now.
4. Introduce a syntax error, save → confirm the last-good render stays displayed (no blank/broken canvas), terminal shows the lilypond error.
5. Fix the error, save → confirm it re-renders, still without moving scroll.
6. Reload the browser tab (a real page reload, not a save-triggered one) → confirm it renders correctly from a cold start (scroll position resetting here is fine and expected, since it's a genuine navigation, not our reload path).

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Replace PDF embed with scroll-preserving pdf.js canvas viewer"
```

---

## Post-plan

None — this plan fully implements the spec.
