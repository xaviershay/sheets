# bin/dev Error Banner Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Surface lilypond compile errors in the browser (a fixed banner, not replacing the PDF), clearing automatically on the next successful compile, without disturbing `#pdf-pages`'s scroll position.

**Architecture:** New SSE event type `error`, pushed from `compile()`'s existing failure branch alongside the existing `console.error`. Client shows/hides a fixed-position `<pre>` banner in response to `error`/`reload` SSE events; the banner element is a sibling of `#pdf-pages`, never touching it.

**Tech Stack:** Same as the rest of `bin/dev` — Node built-ins, Server-Sent Events, no new dependencies.

## Global Constraints

- Full lilypond stderr text shown, not a summary, in a monospace `<pre>`. (Spec: Banner content)
- Banner never removes/recreates `#pdf-pages` or its canvases — scroll position preservation from the prior fix must hold. (Spec: Fix)
- Banner capped at ~40% viewport height with its own internal scroll. (Spec: Banner content)
- SSE `data:` payload for the error must be JSON-encoded (raw multi-line stderr isn't valid in a single SSE `data:` line). (Spec: Fix)

---

## File Structure

- Modify: `bin/dev` — one new server-side function (`pushError`), one new SSE-triggering call site, and client-side banner markup + SSE handling in `PAGE_HTML`.

---

### Task 1: Server — push compile errors over SSE

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Produces: `pushError(message)`, called from `compile()`'s failure branch. Sends `event: error\ndata: <JSON-encoded message>\n\n` to all connected SSE clients. Task 2's client code depends on this exact event name and JSON-encoded payload shape.

- [ ] **Step 1: Add `pushError` next to the existing `pushReload`**

Change:

```javascript
function pushReload() {
  for (const res of sseClients) res.write('event: reload\ndata: {}\n\n');
}
```

to:

```javascript
function pushReload() {
  for (const res of sseClients) res.write('event: reload\ndata: {}\n\n');
}

function pushError(message) {
  for (const res of sseClients) res.write('event: error\ndata: ' + JSON.stringify(message) + '\n\n');
}
```

- [ ] **Step 2: Call it from the compile failure branch**

Change:

```javascript
    } else {
      console.error('lilypond failed:\n' + stderr);
    }
```

to:

```javascript
    } else {
      console.error('lilypond failed:\n' + stderr);
      pushError(stderr);
    }
```

- [ ] **Step 3: Verify manually**

Run: `node --check bin/dev` — expect no output.

Run: `bin/dev src/lilypond/chameleon.ly` in the background, then in another terminal:

```bash
timeout 3 curl -s -N http://localhost:8001/events > /tmp/sse-error-test.txt &
sleep 0.5
echo '{ broken' >> src/lilypond/chameleon.ly
wait
cat /tmp/sse-error-test.txt
git checkout src/lilypond/chameleon.ly
```

Expected: output contains `event: error` followed by a `data:` line with
JSON-encoded lilypond stderr (escaped `\n`s visible as literal `\n` in the
JSON string). The `git checkout` restores the test file afterward.

Stop the server before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Push lilypond compile errors to the browser over SSE"
```

---

### Task 2: Client — show/hide the error banner

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: the `error` SSE event from Task 1.
- Produces: fully working error banner. Last task for this plan.

- [ ] **Step 1: Add the banner element and styling**

Change:

```javascript
<style>
  html,body{margin:0;height:100%}
  #pdf-pages{width:100%;height:100%;overflow:auto;background:#525659}
  #pdf-pages canvas{display:block;margin:0 auto 8px;box-shadow:0 0 4px rgba(0,0,0,0.5)}
</style>
</head>
<body>
<div id="pdf-pages"></div>
```

to:

```javascript
<style>
  html,body{margin:0;height:100%}
  #pdf-pages{width:100%;height:100%;overflow:auto;background:#525659}
  #pdf-pages canvas{display:block;margin:0 auto 8px;box-shadow:0 0 4px rgba(0,0,0,0.5)}
  #error-banner{display:none;position:fixed;top:0;left:0;right:0;max-height:40%;overflow:auto;
    margin:0;padding:12px;background:#3a0d0d;color:#ffb4b4;font:12px/1.4 monospace;
    white-space:pre-wrap;box-shadow:0 2px 6px rgba(0,0,0,0.6);z-index:1}
</style>
</head>
<body>
<pre id="error-banner"></pre>
<div id="pdf-pages"></div>
```

- [ ] **Step 2: Wire the SSE `error`/`reload` handlers**

Change:

```javascript
  renderPdf('/out.pdf').catch(() => {});

  const es = new EventSource('/events');
  es.addEventListener('reload', () => {
    renderPdf('/out.pdf?t=' + Date.now());
  });
```

to:

```javascript
  renderPdf('/out.pdf').catch(() => {});

  const errorBanner = document.getElementById('error-banner');

  const es = new EventSource('/events');
  es.addEventListener('reload', () => {
    errorBanner.style.display = 'none';
    renderPdf('/out.pdf?t=' + Date.now());
  });
  es.addEventListener('error', (e) => {
    errorBanner.textContent = JSON.parse(e.data);
    errorBanner.style.display = 'block';
  });
```

- [ ] **Step 3: Full manual verification pass, per spec**

Run: `bin/dev src/lilypond/chameleon.ly`, open the page in a browser.

1. Scroll down. Introduce a syntax error in `chameleon.ly`, save → confirm
   the red banner appears with the full lilypond error text, the PDF
   underneath is untouched, and scroll position hasn't moved.
2. Fix the error, save → confirm the banner disappears and the PDF
   reloads normally.
3. Revert any leftover test edits: `git checkout src/lilypond/chameleon.ly`
   if needed.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Show lilypond compile errors in a browser banner"
```

---

## Post-plan

None — this plan fully implements the spec.
