# Replace Shake/Haskell build with vendored BuildPlan (Ruby)

## Problem

The site build (`Build.hs`, run via `stack build && stack exec shake-build`)
uses Haskell/Shake. Want to replace it with the same approach used in
`../blog-v2`: a small vendored Ruby dependency-tracking library
(`BuildPlan`, digest-based) plus a `Buildfile` that defines the actual
build graph — dropping the entire Haskell/Stack toolchain.

## Vendoring

`src/ruby/build_plan.rb`, copied verbatim from `../blog-v2`'s
`src/ruby/build_plan.rb` (293 lines). Pure Ruby stdlib — `set`,
`digest/md5`, `logger`, `fileutils`, `json` — zero gem dependencies. No
Gemfile needed for sheets; `../blog-v2`'s Gemfile exists for its own
markdown/ERB pipeline (kramdown, webrick, etc.), none of which sheets uses.

`BuildPlan` provides: `file`/`grouped_file` (declare a target with
dependencies and a build block), `directory` (ensure a directory exists),
`task` (a synthetic target with no output file, e.g. the top-level
`"build"` target), and `build_plan.build("build")` to actually run
everything whose dependencies changed since the last run (tracked via MD5
digests persisted to a JSON file) or whose target doesn't exist yet.

## Buildfile

New file at the repo root (matching `../blog-v2`'s `Buildfile` location),
requiring `build_plan` off `src/ruby` on the load path:

- For each `src/lilypond/*.ly` file, a `grouped_file` target
  `www/static/<name>.pdf`, depending on `[File.dirname(target), ly_file]`,
  running `lilypond -dno-point-and-click -o <output_base> <ly_file>` (the
  `-dno-point-and-click` flag carries forward from the current `Build.hs`,
  keeping production PDFs free of source-link annotations). This is a
  straight port of `Build.hs`'s existing `dest <> "//*.pdf"` rule.
- One `grouped_file` target `www/index.html`, depending only on
  `["src/www/index.html", "www"]` (the source file and the output
  directory) — **not** on the PDF targets. Copying `index.html` doesn't
  depend on the PDFs' content; the PDFs just need to exist by the time the
  overall build is considered done, which is a top-level concern, not
  something `index.html`'s own target should be coupled to.
- A top-level `task "build" => ["www/index.html"] + pdf_files` — this is
  where the PDF targets actually get pulled into the build (mirroring
  `../blog-v2`'s own top-level `task "build" => SITE_FILES` pattern, where
  `SITE_FILES` lists every output as a sibling rather than nesting them
  inside each other's dependency lists).
- `directory "www/static"` and `directory "www"` targets, as dependencies
  of the file targets that write into those directories (matching how
  `Build.hs` implicitly created directories via Shake's own machinery —
  `BuildPlan` requires this explicitly via `directory`).
- Digests persisted to `.digests.json` at the repo root (gitignored),
  loaded at the start of a build and saved at the end
  (`build_plan.save_digests!`) — this is what makes rebuilds skip
  `lilypond` entirely for `.ly` files whose content hasn't changed since
  the last build, replacing Shake's own incremental-build bookkeeping.

## Removed entirely

The whole Haskell/Stack toolchain: `Build.hs`, `package.yaml`,
`sheets-emporium.cabal`, `stack.yaml`, `stack.yaml.lock`, `.stack-work/`,
`_build/` (Shake's own cache directory).

## `bin/compile`

Changes from:

    stack build && exec stack exec shake-build

to:

    exec ruby Buildfile

matching `../blog-v2`'s `bin/build` (`exec ruby Buildfile`). This also
permanently closes the stale-binary class of bug found while adding the
`-dno-point-and-click` flag (`bin/compile` running a days-old compiled
binary that never saw a `Build.hs` source change) — there's no compiled
binary in this approach at all, so it can't go stale.

## New `bin/clean`

`../blog-v2` has one (`rm -rf out`); sheets' old Shake `clean` phony target
had no wrapper script at all. Adding `bin/clean` now:

    rm -rf www .digests.json

## `.gitignore`

Remove `.stack-work`, `_build`, `sheets-emporium.cabal` (all now
nonexistent/irrelevant). Add `.digests.json`.

## Untouched

`bin/dev`, `bin/format`, `bin/serve`, `bin/publish` — none of them invoke
the Haskell toolchain or `Build.hs`; only `bin/compile` does.

## Testing (manual)

- `bin/compile` from a clean checkout (no `.digests.json`, no `www/`)
  produces the same `www/static/*.pdf` and `www/index.html` output as the
  current Haskell build (spot-check one PDF's page count/content looks
  right; confirm `-dno-point-and-click` still holds — 0 source-link
  references, matching the already-verified behavior from the current
  `Build.hs`).
- Running `bin/compile` a second time with no source changes is fast and
  reports nothing needed rebuilding (the digest-based skip working).
- Touching one `.ly` file and rebuilding only recompiles that one file's
  PDF, not all of them.
- Editing `src/www/index.html` and rebuilding updates `www/index.html`
  without needing any `.ly` file to have changed.
- `bin/clean` removes `www/` and `.digests.json`; a subsequent
  `bin/compile` rebuilds everything from scratch.
