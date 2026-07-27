# bin/dev MIDI Playback Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Play the compiled MIDI directly from `bin/dev`'s browser page, via a persistent header bar, alongside the existing PDF preview.

**Architecture:** `compile()` already copies lilypond's PDF output to a temp path and serves it at `/out.pdf`, re-pushing on every successful compile via the existing `reload` SSE event. MIDI follows the identical path: copy `<outBase>.midi` to a temp path (when lilypond produced one), serve at `/out.mid`, and update a `<midi-player>` element's `src` on the same `reload` event the PDF already listens to. The player library loads from a CDN `<script>` tag with a graceful offline fallback so the rest of the page (PDF, error/warning banners) is unaffected if the CDN is unreachable.

**Tech Stack:** Same as the rest of `bin/dev` — Node built-ins, Server-Sent Events, no new server dependencies. Client adds one CDN-loaded library: [html-midi-player](https://github.com/cifkao/html-midi-player) (combined jsdelivr bundle of tone.js + magenta + the player itself), which fetches GM instrument/drum samples from Google's `sgm_plus` soundfont CDN at playback time.

## Global Constraints

- Not every `.ly` file has a `\midi {}` block — `/out.mid` must 404 cleanly when no MIDI was produced, and the client must show a plain "no MIDI for this score" state rather than a broken player. (Spec: Server / Client: persistent header bar)
- Playback never auto-starts. A `reload` fires on every keystroke-triggered recompile while editing; autoplay would fire constantly. (Spec: Client: persistent header bar)
- On `reload`, if MIDI was playing, it stops — the old audio no longer matches the just-recompiled score. (Spec: Client: persistent header bar)
- The MIDI player must degrade gracefully if the CDN is unreachable: PDF viewing and the error/warning banners must keep working untouched. (Spec: Graceful offline fallback)
- The new header bar sits above everything, including the existing `#error-banner`/`#warning-banner`, which shift from `top: 0` to sit below it. (Spec: Client: persistent header bar)

---

## File Structure

- Modify: `bin/dev` — one new temp-file path + route (server), one new fixed header bar + CDN script + SSE wiring (client, inside `PAGE_HTML`).

---

### Task 1: Server — serve the compiled MIDI at `/out.mid`

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Produces: `GET /out.mid` — 200 with `Content-Type: audio/midi` and the latest compiled MIDI bytes if the last successful compile produced one, 404 otherwise. Task 2/3's client code depends on this exact URL and status-code contract.

- [ ] **Step 1: Add the `outMidi` temp path next to `outPdf`**

Change:

```javascript
const outPdf = path.join(os.tmpdir(), 'bin-dev-out.pdf');
```

to:

```javascript
const outPdf = path.join(os.tmpdir(), 'bin-dev-out.pdf');
const outMidi = path.join(os.tmpdir(), 'bin-dev-out.mid');
```

- [ ] **Step 2: Copy or clear the MIDI output alongside the PDF copy in `compile()`**

Change:

```javascript
    if (code === 0) {
      fs.copyFileSync(outBase + '.pdf', outPdf);
      const warnings = extractWarnings(stderr);
```

to:

```javascript
    if (code === 0) {
      fs.copyFileSync(outBase + '.pdf', outPdf);
      if (fs.existsSync(outBase + '.midi')) {
        fs.copyFileSync(outBase + '.midi', outMidi);
      } else if (fs.existsSync(outMidi)) {
        fs.rmSync(outMidi);
      }
      const warnings = extractWarnings(stderr);
```

- [ ] **Step 3: Add the `/out.mid` route**

Change:

```javascript
  } else if (req.url.startsWith('/out.pdf')) {
    if (!fs.existsSync(outPdf)) {
      res.writeHead(404);
      res.end();
      return;
    }
    res.writeHead(200, { 'Content-Type': 'application/pdf' });
    fs.createReadStream(outPdf).pipe(res);
  } else if (req.url === '/vendor/pdf.min.mjs') {
```

to:

```javascript
  } else if (req.url.startsWith('/out.pdf')) {
    if (!fs.existsSync(outPdf)) {
      res.writeHead(404);
      res.end();
      return;
    }
    res.writeHead(200, { 'Content-Type': 'application/pdf' });
    fs.createReadStream(outPdf).pipe(res);
  } else if (req.url.startsWith('/out.mid')) {
    if (!fs.existsSync(outMidi)) {
      res.writeHead(404);
      res.end();
      return;
    }
    res.writeHead(200, { 'Content-Type': 'audio/midi' });
    fs.createReadStream(outMidi).pipe(res);
  } else if (req.url === '/vendor/pdf.min.mjs') {
```

- [ ] **Step 4: Verify manually**

Run: `node --check bin/dev` — expect no output.

Run `bin/dev src/lilypond/nothing-breaks.ly` (has a `\midi {}` block) in the background, then:

```bash
sleep 2
curl -sI http://localhost:8001/out.mid | head -5
```

Expected: `HTTP/1.1 200 OK` and `Content-Type: audio/midi`.

Stop that server, then run `bin/dev src/lilypond/i-wish-i-knew.ly` (no `\midi {}` block):

```bash
sleep 2
curl -sI http://localhost:8001/out.mid | head -5
```

Expected: `HTTP/1.1 404 Not Found`.

Stop the server before continuing.

- [ ] **Step 5: Commit**

```bash
git add bin/dev
git commit -m "Serve compiled MIDI at /out.mid in bin/dev"
```

---

### Task 2: Client — persistent header bar with the MIDI player, CDN-loaded with offline fallback

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: nothing from Task 1 yet (this task only builds the static page structure and library bootstrap; wiring to `/out.mid` and the `reload` event is Task 3).
- Produces: `#midi-bar` (fixed header, height `40px`, `top: 0`), containing either a working `<midi-player id="midi-player">` (library loaded) or a plain text fallback (library unavailable). `#error-banner`/`#warning-banner` shift to `top: 40px`. Task 3 depends on `#midi-bar` and `#midi-player` existing with these exact ids.

- [ ] **Step 1: Add the header bar element and shift the existing banners down**

Change:

```javascript
<style>
  html,body{margin:0;height:100%}
  #pdf-pages{width:100%;height:100%;overflow:auto;background:#525659}
  #pdf-pages canvas{display:block;margin:0 auto 8px;box-shadow:0 0 4px rgba(0,0,0,0.5)}
  #error-banner{display:none;position:fixed;top:0;left:0;right:0;max-height:40%;overflow:auto;
    margin:0;padding:12px;background:#3a0d0d;color:#ffffff;font:15px/1.5 monospace;
    white-space:pre-wrap;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:1}
  #warning-banner{display:none;position:fixed;top:0;left:0;right:0;max-height:40%;overflow:auto;
    margin:0;padding:12px;background:#4a3a0d;color:#ffffff;font:15px/1.5 monospace;
    white-space:pre-wrap;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:1}
</style>
</head>
<body>
<pre id="error-banner"></pre>
<pre id="warning-banner"></pre>
<div id="pdf-pages"></div>
```

to:

```javascript
<style>
  html,body{margin:0;height:100%}
  #pdf-pages{width:100%;height:100%;overflow:auto;background:#525659}
  #pdf-pages canvas{display:block;margin:0 auto 8px;box-shadow:0 0 4px rgba(0,0,0,0.5)}
  #midi-bar{position:fixed;top:0;left:0;right:0;height:40px;display:flex;align-items:center;
    padding:0 12px;background:#222;color:#aaa;font:13px/1 monospace;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:2}
  #error-banner{display:none;position:fixed;top:40px;left:0;right:0;max-height:40%;overflow:auto;
    margin:0;padding:12px;background:#3a0d0d;color:#ffffff;font:15px/1.5 monospace;
    white-space:pre-wrap;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:1}
  #warning-banner{display:none;position:fixed;top:40px;left:0;right:0;max-height:40%;overflow:auto;
    margin:0;padding:12px;background:#4a3a0d;color:#ffffff;font:15px/1.5 monospace;
    white-space:pre-wrap;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:1}
</style>
</head>
<body>
<div id="midi-bar">loading player…</div>
<pre id="error-banner"></pre>
<pre id="warning-banner"></pre>
<div id="pdf-pages"></div>
```

- [ ] **Step 2: Load the player library from CDN with a graceful offline fallback**

Change:

```javascript
<script type="module">
  import * as pdfjsLib from '/vendor/pdf.min.mjs';
  pdfjsLib.GlobalWorkerOptions.workerSrc = '/vendor/pdf.worker.min.mjs';

  const container = document.getElementById('pdf-pages');
```

to:

```javascript
<script type="module">
  import * as pdfjsLib from '/vendor/pdf.min.mjs';
  pdfjsLib.GlobalWorkerOptions.workerSrc = '/vendor/pdf.worker.min.mjs';

  const midiBar = document.getElementById('midi-bar');

  function midiPlayerUnavailable() {
    midiBar.textContent = 'MIDI unavailable (offline)';
  }

  const midiScript = document.createElement('script');
  midiScript.src = 'https://cdn.jsdelivr.net/combine/npm/tone@14.7.58,npm/@magenta/music@1.23.1/es6/core.js,npm/html-midi-player@1.5.0';
  midiScript.onerror = midiPlayerUnavailable;
  midiScript.onload = () => {
    if (!customElements.get('midi-player')) {
      midiPlayerUnavailable();
      return;
    }
    midiBar.innerHTML = '<midi-player id="midi-player" sound-font></midi-player>';
  };
  document.head.appendChild(midiScript);

  const container = document.getElementById('pdf-pages');
```

- [ ] **Step 3: Verify manually**

Run: `node --check bin/dev` — expect no output.

Run `bin/dev src/lilypond/nothing-breaks.ly`, open `http://localhost:8001` in a browser:

1. Confirm the header bar appears at the top and, once the CDN script
   loads, shows a working `<midi-player>` play button.
2. Confirm `#error-banner`/`#warning-banner` (trigger one by introducing
   a bar-check issue) now render below the header bar, not overlapping
   it.
3. Simulate offline: in devtools, block requests to `cdn.jsdelivr.net`
   (Network tab → block request domain, or just disconnect network),
   reload the page → confirm the bar shows "MIDI unavailable (offline)"
   and the PDF still renders normally.

Stop the server before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Add persistent MIDI player header bar to bin/dev"
```

---

### Task 3: Client — wire the player to `/out.mid` and the `reload` event

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `/out.mid` (Task 1), `#midi-player` element (Task 2, may not exist if the CDN load failed or hasn't finished yet — must be guarded).
- Produces: fully working end-to-end playback. Last task for this plan.

- [ ] **Step 1: Point the player at `/out.mid` once it's created, and refresh it on reload**

Change:

```javascript
    midiBar.innerHTML = '<midi-player id="midi-player" sound-font></midi-player>';
  };
  document.head.appendChild(midiScript);

  const container = document.getElementById('pdf-pages');
```

to:

```javascript
    midiBar.innerHTML = '<midi-player id="midi-player" sound-font></midi-player>';
    refreshMidiSrc();
  };
  document.head.appendChild(midiScript);

  function refreshMidiSrc() {
    const player = document.getElementById('midi-player');
    if (!player) return;
    player.stop();
    fetch('/out.mid', { method: 'HEAD' }).then((res) => {
      player.style.display = res.ok ? '' : 'none';
      if (res.ok) player.src = '/out.mid?t=' + Date.now();
    });
  }

  const container = document.getElementById('pdf-pages');
```

- [ ] **Step 2: Call it from the existing `reload` SSE handler**

Change:

```javascript
  const es = new EventSource('/events');
  es.addEventListener('reload', (e) => {
    errorBanner.style.display = 'none';
    const { warning } = JSON.parse(e.data);
    if (warning) {
      warningBanner.textContent = warning;
      warningBanner.style.display = 'block';
    } else {
      warningBanner.style.display = 'none';
    }
    renderPdf('/out.pdf?t=' + Date.now());
  });
```

to:

```javascript
  const es = new EventSource('/events');
  es.addEventListener('reload', (e) => {
    errorBanner.style.display = 'none';
    const { warning } = JSON.parse(e.data);
    if (warning) {
      warningBanner.textContent = warning;
      warningBanner.style.display = 'block';
    } else {
      warningBanner.style.display = 'none';
    }
    renderPdf('/out.pdf?t=' + Date.now());
    refreshMidiSrc();
  });
```

- [ ] **Step 3: Full manual verification pass, per spec**

Run: `bin/dev src/lilypond/nothing-breaks.ly`, open the page in a browser.

1. Once the player loads, press play → confirm audio plays, including
   drums.
2. While playing, edit a note in `src/lilypond/nothing-breaks.ly` and
   save → confirm the recompile stops playback (per the reload
   handler), and pressing play again plays the updated MIDI (change a
   note enough to be audible, e.g. move a melody note up an octave, to
   confirm it's really the new file).
3. Revert the edit: `git checkout src/lilypond/nothing-breaks.ly` if
   anything was left changed.

Stop that server, then run `bin/dev src/lilypond/i-wish-i-knew.ly`
(no `\midi {}` block):

4. Confirm the player element is hidden (no broken/empty player shown)
   and the PDF still renders normally.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Wire MIDI player to /out.mid and reload events in bin/dev"
```

---

## Post-plan

None — this plan fully implements the spec.
