# Sheets

Assorted lilypond scores and a pretty webpage to host them: https://sheets.xaviershay.com

## Requirements

    sudo apt install lilypond # 2.24.4 at time of writing
    sudo apt install python-ly # Only required for bin/format

## Development

    bin/dev src/lilypond/whatever.ly    # Dev server at :8001
    bin/format src/lilypond/whatever.ly # Auto-formatter
    bin/compile && bin/serve            # Website at :8000

## Building and Publishing Website

Publishing requires `aws-cli` configured with `aws configure`.

    bin/compile
    bin/publish
