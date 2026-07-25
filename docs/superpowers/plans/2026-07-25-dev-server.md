# Lilypond Dev Server Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build `bin/dev <file.ly>`, a zero-dependency Node.js script that recompiles a lilypond file on save and pushes a browser reload over Server-Sent Events, so a locally-edited PDF stays live in a browser tab.

**Architecture:** One Node.js script (`bin/dev`) that is simultaneously: an HTTP server (serves the viewer page, the latest compiled PDF, and an SSE stream), a file watcher (`fs.watch` on the target file's directory), and a compiler driver (shells out to `lilypond`). Built incrementally in one file, each task adding one capability, each verified by actually running the script and hitting it with `curl`/a browser.

**Tech Stack:** Node.js (built-ins only: `http`, `fs`, `path`, `child_process`, `os` — no npm packages), `lilypond` CLI (already on the system).

## Global Constraints

- Zero npm dependencies — Node built-ins only. (Spec: Architecture)
- Fixed port `8001` — `bin/serve` already owns `8000`. (Spec: Architecture)
- Reload is push-only via SSE (`/events`), never client-side polling. (Spec: Problem)
- Server process must never exit due to a lilypond compile failure; last-good PDF keeps serving. (Spec: Error handling)
- Reload fires on every successful recompile — no output-hash comparison, no "did it really change" gate. (Spec: Compile flow)
- Watch the target file's *directory* (non-recursive) for `*.ly` changes, not just the single argument file, to catch multi-file pieces with sibling `\include`s. (Spec: Architecture)

---

## File Structure

- Create: `bin/dev` — the entire tool (HTTP server + watcher + compiler + embedded page HTML). Single file, following the existing `bin/compile`, `bin/serve`, `bin/publish` pattern of small standalone scripts in `bin/`.

No other files change. This plan builds `bin/dev` in five incremental, independently-runnable stages.

---

### Task 1: HTTP server skeleton — page, PDF placeholder, 404s

**Files:**
- Create: `bin/dev`

**Interfaces:**
- Produces: `PORT = 8001` constant; `outPdf` path constant (`path.join(os.tmpdir(), 'bin-dev-out.pdf')`) that later tasks write to; `PAGE_HTML` template string that later tasks extend with the SSE client script.

- [ ] **Step 1: Write `bin/dev` with arg parsing, constants, and a bare HTTP server**

```javascript
#!/usr/bin/env node
'use strict';

const http = require('http');
const fs = require('fs');
const path = require('path');
const os = require('os');

const PORT = 8001;

const target = process.argv[2];
if (!target) {
  console.error('usage: bin/dev <file.ly>');
  process.exit(1);
}

const targetAbs = path.resolve(target);
const targetDir = path.dirname(targetAbs);
const targetBase = path.basename(targetAbs);
const outPdf = path.join(os.tmpdir(), 'bin-dev-out.pdf');

const PAGE_HTML = `<!doctype html>
<html>
<head><meta charset="utf-8"><title>dev: ${targetBase}</title>
<style>html,body{margin:0;height:100%} embed{width:100%;height:100%;border:0}</style>
</head>
<body>
<embed id="pdf" src="/out.pdf" type="application/pdf">
</body>
</html>`;

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(PAGE_HTML);
  } else if (req.url.startsWith('/out.pdf')) {
    if (!fs.existsSync(outPdf)) {
      res.writeHead(404);
      res.end();
      return;
    }
    res.writeHead(200, { 'Content-Type': 'application/pdf' });
    fs.createReadStream(outPdf).pipe(res);
  } else {
    res.writeHead(404);
    res.end();
  }
});

server.listen(PORT, () => {
  console.log(`serving http://localhost:${PORT}  (watching ${targetDir} for ${targetBase})`);
});
```

- [ ] **Step 2: Make it executable**

Run: `chmod +x bin/dev`

- [ ] **Step 3: Run it and verify the skeleton responds**

Run in one terminal: `bin/dev src/lilypond/chameleon.ly`
Expected: prints `serving http://localhost:8001  (watching .../src/lilypond for chameleon.ly)`

In another terminal:
```bash
curl -s http://localhost:8001/ | grep -o '<title>[^<]*</title>'
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/out.pdf
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/nonsense
```
Expected: `<title>dev: chameleon.ly</title>`, then `404` (no PDF compiled yet), then `404` (unknown route).

Stop the server (Ctrl-C) before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Add bin/dev HTTP server skeleton (page + PDF route, no compile yet)"
```

---

### Task 2: Compile on startup

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `targetAbs`, `outPdf` from Task 1.
- Produces: `compile()` function — runs lilypond once, copies result to `outPdf` on success, logs stderr on failure, never throws. Later tasks call `compile()` from the watcher and wrap it with debounce/reentrancy guards.

- [ ] **Step 1: Add `child_process` require and a `compile()` function, call it after `server.listen`**

Add near the top, with the other requires:

```javascript
const { spawn } = require('child_process');
```

Add before the `server` declaration:

```javascript
function compile() {
  const tmpOutDir = fs.mkdtempSync(path.join(os.tmpdir(), 'bin-dev-'));
  const outBase = path.join(tmpOutDir, path.basename(targetBase, '.ly'));
  const proc = spawn('lilypond', ['-o', outBase, targetAbs]);
  let stderr = '';
  proc.stderr.on('data', (d) => { stderr += d; });
  proc.on('close', (code) => {
    if (code === 0) {
      fs.copyFileSync(outBase + '.pdf', outPdf);
      console.log('compiled ok');
    } else {
      console.error('lilypond failed:\n' + stderr);
    }
    fs.rmSync(tmpOutDir, { recursive: true, force: true });
  });
}
```

Change the `server.listen` callback to also trigger a compile:

```javascript
server.listen(PORT, () => {
  console.log(`serving http://localhost:${PORT}  (watching ${targetDir} for ${targetBase})`);
  compile();
});
```

- [ ] **Step 2: Run and verify the PDF becomes available**

Run: `bin/dev src/lilypond/chameleon.ly`
Expected: after ~1-2s, terminal prints `compiled ok`.

In another terminal:
```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/out.pdf
```
Expected: `200`

- [ ] **Step 3: Verify a bad file doesn't crash the server**

Stop the server. Run: `bin/dev /tmp/does-not-exist.ly`
Expected: terminal prints `lilypond failed:` followed by lilypond's error, and the process **keeps running** (does not exit). Confirm with:
```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8001/
```
Expected: `200` (server still up).

Stop the server before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Compile the target file on server startup"
```

---

### Task 3: Watch for changes, debounce, recompile

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `compile()`, `targetDir` from Tasks 1-2.
- Produces: `scheduleCompile()` — debounced, reentrancy-safe trigger that later tasks (the `fs.watch` callback) call on every detected `.ly` change. `compile()`'s signature stays the same but gains internal `compiling`/`pending` guards so overlapping triggers don't spawn concurrent lilypond processes.

- [ ] **Step 1: Add reentrancy guards to `compile()` and a debounced `scheduleCompile()`, wired to `fs.watch`**

Replace the `compile()` function with:

```javascript
let compiling = false;
let pending = false;

function compile() {
  if (compiling) {
    pending = true;
    return;
  }
  compiling = true;
  const tmpOutDir = fs.mkdtempSync(path.join(os.tmpdir(), 'bin-dev-'));
  const outBase = path.join(tmpOutDir, path.basename(targetBase, '.ly'));
  const proc = spawn('lilypond', ['-o', outBase, targetAbs]);
  let stderr = '';
  proc.stderr.on('data', (d) => { stderr += d; });
  proc.on('close', (code) => {
    compiling = false;
    if (code === 0) {
      fs.copyFileSync(outBase + '.pdf', outPdf);
      console.log('compiled ok');
    } else {
      console.error('lilypond failed:\n' + stderr);
    }
    fs.rmSync(tmpOutDir, { recursive: true, force: true });
    if (pending) {
      pending = false;
      compile();
    }
  });
}

let debounceTimer = null;

function scheduleCompile() {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(compile, 300);
}

fs.watch(targetDir, (eventType, filename) => {
  if (filename && filename.endsWith('.ly')) scheduleCompile();
});
```

- [ ] **Step 2: Run and verify a save triggers a recompile**

Run: `bin/dev src/lilypond/chameleon.ly`
Expected: `compiled ok` printed once on startup.

In another terminal, touch the file to simulate a save:
```bash
touch src/lilypond/chameleon.ly
```
Expected: within ~300-500ms, terminal prints `compiled ok` a second time.

- [ ] **Step 3: Verify rapid saves are debounced, not spawning overlapping compiles**

While the server is running:
```bash
for i in 1 2 3 4 5; do touch src/lilypond/chameleon.ly; sleep 0.05; done
```
Expected: only **one** additional `compiled ok` line appears (not five), confirming the 300ms debounce coalesced the bursts.

Stop the server before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Watch target directory and recompile on .ly changes, debounced"
```

---

### Task 4: SSE endpoint, push reload on successful compile

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `compile()`'s success path from Task 3.
- Produces: `/events` HTTP route; `pushReload()` function that later tasks (the compile success branch) call. SSE clients receive a `reload` named event with an empty JSON body (`{}`) on every successful compile.

- [ ] **Step 1: Add an SSE client list, `pushReload()`, the `/events` route, and call `pushReload()` after a successful compile**

Add near the top, after `const outPdf = ...`:

```javascript
let sseClients = [];

function pushReload() {
  for (const res of sseClients) res.write('event: reload\ndata: {}\n\n');
}
```

In `compile()`'s `proc.on('close', ...)` success branch, add the push:

```javascript
    if (code === 0) {
      fs.copyFileSync(outBase + '.pdf', outPdf);
      console.log('compiled ok');
      pushReload();
    } else {
```

Add a new branch in the `http.createServer` handler (alongside `/`, `/out.pdf`, and the `else` 404):

```javascript
  } else if (req.url === '/events') {
    res.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      Connection: 'keep-alive',
    });
    res.write('\n');
    sseClients.push(res);
    req.on('close', () => {
      sseClients = sseClients.filter((c) => c !== res);
    });
```

(This new branch goes before the final `else { res.writeHead(404); ... }`.)

- [ ] **Step 2: Run and verify the SSE stream emits a `reload` event on save**

Run: `bin/dev src/lilypond/chameleon.ly`

In another terminal, start listening to the stream in the background and capture output:
```bash
timeout 3 curl -s -N http://localhost:8001/events > /tmp/sse-output.txt &
sleep 0.5
touch src/lilypond/chameleon.ly
wait
cat /tmp/sse-output.txt
```
Expected: output contains `event: reload` and `data: {}`.

- [ ] **Step 3: Verify a failed compile does not push a reload**

With the server still running:
```bash
timeout 3 curl -s -N http://localhost:8001/events > /tmp/sse-output2.txt &
sleep 0.5
echo '{ broken lilypond' >> src/lilypond/chameleon.ly
wait
cat /tmp/sse-output2.txt
git checkout src/lilypond/chameleon.ly
```
Expected: `/tmp/sse-output2.txt` is empty (no `reload` event), and the terminal running `bin/dev` printed `lilypond failed:`. The `git checkout` restores the file afterward.

Stop the server before continuing.

- [ ] **Step 4: Commit**

```bash
git add bin/dev
git commit -m "Add SSE /events endpoint, push reload on successful compile"
```

---

### Task 5: Client-side reload wiring + full manual verification

**Files:**
- Modify: `bin/dev`

**Interfaces:**
- Consumes: `/events` SSE stream from Task 4.
- Produces: complete, working `bin/dev` tool — this is the final task, matching the spec's "Testing (manual)" section.

- [ ] **Step 1: Add the `EventSource` client script to `PAGE_HTML`**

Replace `PAGE_HTML`'s body with:

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

- [ ] **Step 2: Full manual pass per spec, in a browser**

Run: `bin/dev src/lilypond/chameleon.ly`, open `http://localhost:8001/` in a browser.

1. Edit a note in `src/lilypond/chameleon.ly`, save → PDF reloads in the browser with the change visible.
2. Introduce a syntax error (e.g. add a stray `{`), save → PDF stays as the last good version; terminal shows `lilypond failed:` and the error.
3. Fix the error, save → PDF reloads again with the fix.
4. Leave the page open and idle for 15-20s without saving → confirm the PDF never reloads on its own (rules out any accidental polling behavior).

Revert any test edits to `chameleon.ly` afterward: `git checkout src/lilypond/chameleon.ly`

- [ ] **Step 3: Commit**

```bash
git add bin/dev
git commit -m "Wire browser-side reload via EventSource, completing bin/dev"
```

---

## Post-plan

Update `README.md`'s "Compiling individual pieces" section to mention `bin/dev <file.ly>` as the live-reload option, if the user wants it documented — not required by the spec, so left as a follow-up rather than a task here.
