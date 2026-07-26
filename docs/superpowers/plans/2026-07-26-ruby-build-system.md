# Ruby Build System Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Haskell/Shake build (`Build.hs`, `stack`) with the same approach used in `../blog-v2`: a vendored digest-based `BuildPlan` Ruby library plus a `Buildfile` that defines the build graph.

**Architecture:** `src/ruby/build_plan.rb`, copied verbatim from `../blog-v2`, is the reusable dependency-tracking engine (pure stdlib, no gems). A new root-level `Buildfile` defines targets for each `.ly` → `.pdf` compile and the `index.html` copy, using that library. `bin/compile` becomes a one-line `exec ruby Buildfile`. The whole Haskell/Stack toolchain is deleted once the new build is proven working.

**Tech Stack:** Ruby (stdlib only — no Gemfile, no gems). `lilypond` CLI (unchanged dependency).

## Global Constraints

- No Gemfile/Bundler — `build_plan.rb` has zero gem dependencies, and neither does the new `Buildfile`. (Spec: Vendoring)
- `.ly` → `.pdf` compile uses `-dno-point-and-click` (carried forward from the current `Build.hs`, keeping production PDFs link-free). (Spec: Buildfile)
- `www/index.html`'s target depends only on `src/www/index.html` and the `www` directory — **not** on the PDF targets. PDFs are pulled into the build via the top-level `"build"` task depending on both `www/index.html` and every PDF as siblings. (Spec: Buildfile — this was a correction from the initial design)
- Digests persist to `.digests.json` at the repo root, gitignored. (Spec: Buildfile)
- `bin/dev`, `bin/format`, `bin/serve`, `bin/publish` are untouched — only `bin/compile` invokes the build. (Spec: Untouched)

**Known library quirk (inherited from `../blog-v2`, not something to fix here):** `build_plan.rb`'s `Synthetic` target (used for `task`) calls `@block.call` unconditionally — a `task` declared without a `do...end` block raises `NoMethodError`. Every `task` call in the new `Buildfile` must include a block (even an empty one). Also, `build_plan.rb` references a global `$s` (a `Process.clock_gettime` timestamp) for its own timing stats — the calling `Buildfile` must set `$s = Process.clock_gettime(Process::CLOCK_MONOTONIC)` as its first line, exactly as `../blog-v2`'s `Buildfile` does, or `build_plan.build` raises `TypeError`. Both of these were caught by actually running a dry-run build against a scratch copy of this repo's real `src/lilypond` tree before writing this plan — the `Buildfile` content in Task 2 below already has both fixes applied.

---

## File Structure

- Create: `src/ruby/build_plan.rb` (vendored from `../blog-v2`).
- Create: `Buildfile` (repo root).
- Modify: `bin/compile`, `.gitignore`.
- Create: `bin/clean`.
- Delete: `Build.hs`, `package.yaml`, `sheets-emporium.cabal`, `stack.yaml`, `stack.yaml.lock`, `.stack-work/`, `_build/`.

---

### Task 1: Vendor `build_plan.rb`

**Files:**
- Create: `src/ruby/build_plan.rb`

**Interfaces:**
- Produces: the `BuildPlan` class (and nested `BuildPlan::Target::*` classes), loadable via `require 'build_plan'` once `src/ruby` is on `$LOAD_PATH`. Task 2's `Buildfile` depends on this.

- [ ] **Step 1: Copy the file verbatim**

```bash
mkdir -p src/ruby
cp ../blog-v2/src/ruby/build_plan.rb src/ruby/build_plan.rb
```

- [ ] **Step 2: Verify it's valid, loadable Ruby**

Run:

```bash
ruby -c src/ruby/build_plan.rb
ruby -Isrc/ruby -e "require 'build_plan'; puts BuildPlan.new.inspect"
```

Expected: `Syntax OK` from the first command; `<BuildPlan: 0 targets>` from the second (confirms the class loads and instantiates with zero gem dependencies beyond stdlib).

- [ ] **Step 3: Commit**

```bash
git add src/ruby/build_plan.rb
git commit -m "Vendor BuildPlan from ../blog-v2"
```

---

### Task 2: Write the `Buildfile`, verify a full clean build

**Files:**
- Create: `Buildfile`

**Interfaces:**
- Consumes: `BuildPlan` from `src/ruby/build_plan.rb` (Task 1).
- Produces: `www/static/<name>.pdf` for every `src/lilypond/*.ly`, and `www/index.html`. Task 4's `bin/compile` invokes this file directly (`ruby Buildfile`).

- [ ] **Step 1: Write the file**

```ruby
$s = Process.clock_gettime(Process::CLOCK_MONOTONIC)

$LOAD_PATH.unshift File.expand_path("./src/ruby", File.dirname(__FILE__))

require 'build_plan'
require 'fileutils'

DIGEST_FILE = File.expand_path(".digests.json", File.dirname(__FILE__))

build_plan = BuildPlan.new(digest_file: DIGEST_FILE)
BuildPlan.logger.level = Logger::INFO

LY_FILES = Dir["src/lilypond/*.ly"]

pdf_files = []

build_plan.load do
  directory "www"
  directory "www/static"

  LY_FILES.each do |ly_file|
    name = File.basename(ly_file, ".ly")
    pdf = "www/static/#{name}.pdf"
    pdf_files << pdf
    output_base = "www/static/#{name}"

    grouped_file "Lilypond", pdf => ["www/static", ly_file] do
      system("lilypond", "-dno-point-and-click", "-o", output_base, ly_file) or
        raise "lilypond failed for #{ly_file}"
    end
  end

  grouped_file "Index", "www/index.html" => ["www", "src/www/index.html"] do
    FileUtils.cp("src/www/index.html", "www/index.html")
  end

  task "build" => ["www/index.html"] + pdf_files do
  end
end

build_plan.build "build"

build_plan.save_digests!(DIGEST_FILE)
```

- [ ] **Step 2: Run a full clean build**

Run:

```bash
rm -rf www .digests.json
ruby Buildfile
```

Expected: compiles all 17 `.ly` files under `src/lilypond/` (not the ones inside its subdirectories — `Dir["src/lilypond/*.ly"]` is non-recursive, matching `Build.hs`'s old `getDirectoryFiles "src/lilypond" ["*.ly"]` behavior exactly, including its existing limitation that multi-file pieces' included sub-files aren't tracked as dependencies), copies `index.html`, and prints a stats summary ending in `Total: <N>ms`. Takes roughly 15-20s (dominated by lilypond itself).

- [ ] **Step 3: Verify the output**

```bash
ls www/static/*.pdf | wc -l
ls www/index.html
strings www/static/chameleon.pdf | grep -c "chameleon.ly\|/Link"
```

Expected: `17`, `www/index.html` exists, and the last command prints `0` — confirming `-dno-point-and-click` carried through the port (the pre-migration `Build.hs` build produces the same `0` for this check, established when that flag was first added).

- [ ] **Step 4: Commit**

```bash
git add Buildfile
git commit -m "Add Buildfile using vendored BuildPlan"
```

(`www/`, `.digests.json` stay untracked/ignored — see Task 4 for the `.gitignore` update. If a commit hook or `git status` complains about them being untracked before that update lands, that's expected and fine — they'll be ignored once Task 4's `.gitignore` change is in.)

---

### Task 3: Verify incremental rebuild behavior

**Files:**
- None modified — this task is verification only, confirming Task 2's `Buildfile` behaves correctly before wiring it into `bin/compile` and deleting the old build system.

**Interfaces:**
- Consumes: the `Buildfile` and its `.digests.json` state from Task 2.

- [ ] **Step 1: Verify a no-op second run is fast**

Run: `time ruby Buildfile 2>&1 | tail -15`
Expected: no `Lilypond` or `Index` group lines in the stats output (nothing needed rebuilding), and wall time under half a second — contrast with Task 2's ~15-20s full build.

- [ ] **Step 2: Verify touching one `.ly` file only rebuilds that file**

Run:

```bash
touch src/lilypond/chameleon.ly
ruby Buildfile 2>&1 | grep "Converting to"
```

Expected: exactly one line, `Converting to \`chameleon.pdf'...` — no other `.ly` file recompiled.

- [ ] **Step 3: Verify editing `src/www/index.html` alone doesn't touch lilypond**

Run:

```bash
touch src/www/index.html
ruby Buildfile 2>&1 | grep -E "Index:|Lilypond:"
```

Expected: an `Index: 1 in ...` line, and **no** `Lilypond:` line — confirms `www/index.html`'s target correctly depends only on the source file and directory, not on the PDF targets (the corrected dependency structure from the design review).

- [ ] **Step 4: No commit** — this task made no file changes.

---

### Task 4: Wire up `bin/compile`/`bin/clean`, update `.gitignore`, remove the Haskell toolchain

**Files:**
- Modify: `bin/compile`, `.gitignore`
- Create: `bin/clean`
- Delete: `Build.hs`, `package.yaml`, `sheets-emporium.cabal`, `stack.yaml`, `stack.yaml.lock`, `.stack-work/`, `_build/`

**Interfaces:**
- Consumes: the working `Buildfile` from Tasks 2-3.
- Produces: fully working `bin/compile`/`bin/clean`, with the Haskell toolchain fully removed. Last task — nothing depends on it.

- [ ] **Step 1: Update `bin/compile`**

Change `bin/compile` from:

```bash
#!/bin/bash

stack build && exec stack exec shake-build
```

to:

```bash
#!/bin/bash

exec ruby Buildfile
```

- [ ] **Step 2: Add `bin/clean`**

```bash
#!/bin/bash

set -ex

rm -rf www .digests.json
```

```bash
chmod +x bin/clean
```

- [ ] **Step 3: Update `.gitignore`**

Change:

```
*.pdf
*_gen.*
*.ps
*.midi
*.mid
.stack-work
_build
sheets-emporium.cabal
_build
.stack-work
www
.env
```

to:

```
*.pdf
*_gen.*
*.ps
*.midi
*.mid
www
.env
.digests.json
```

(Drops the duplicated `_build`/`.stack-work` lines along with `sheets-emporium.cabal`; adds `.digests.json`.)

- [ ] **Step 4: Delete the Haskell toolchain**

```bash
rm -rf Build.hs package.yaml sheets-emporium.cabal stack.yaml stack.yaml.lock .stack-work _build
```

- [ ] **Step 5: Full clean verification with the real `bin/compile`/`bin/clean`**

```bash
bin/clean
bin/compile
ls www/static/*.pdf | wc -l
strings www/static/chameleon.pdf | grep -c "chameleon.ly\|/Link"
```

Expected: `17` PDFs, `0` link references — same as Task 2's direct `ruby Buildfile` verification, now proven through the actual `bin/compile`/`bin/clean` entry points a user would run.

- [ ] **Step 6: Confirm nothing else references the removed files**

```bash
grep -rl "stack\|Build\.hs\|shake-build" --include="*.md" --include="bin/*" . 2>/dev/null
```

Expected: no output (or only unrelated matches, e.g. this plan/spec document itself under `docs/`) — confirms `README.md` and the other `bin/*` scripts don't still reference the removed Haskell build.

- [ ] **Step 7: Commit**

```bash
git add -A
git commit -m "Remove Haskell/Shake build system, use Ruby Buildfile via bin/compile"
```

---

## Post-plan

None — this plan fully implements the spec.
