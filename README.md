# Sheets

## Requirements

Uses nightly lilypond (2.19.83), get it from
http://lilypond.org/downloads/binaries/linux-64/

## Compiling individual pieces

    lilypond src/whatever.ly

## Building Website

    stack build && stack exec shake-build
