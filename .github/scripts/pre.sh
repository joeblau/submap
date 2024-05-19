#!/bin/sh
# Pre project generation script

# Stop Xcode if it's running
pkill Xcode

# Run linters and formatters
if [[ -f ".swiftformat" ]]; then
    swiftformat .
fi

if [[ -f ".swiftlint" ]]; then
    swiftlint autocorrect
fi

if [[ -f "swiftgen.yml" ]]; then
    swiftgen
fi