# Sheets

Assorted lilypond scores and a pretty webpage to host them: https://sheets.xaviershay.com

## Requirements

Uses nightly lilypond (2.19.83), get it from
http://lilypond.org/downloads/binaries/linux-64/

## Compiling individual pieces

    lilypond src/whatever.ly

## Building and Publishing Website

Publishing requires `aws-cli` configured with `aws configure`.

    stack build && stack exec shake-build
    bin/publish
