#!/bin/bash
set -e

# Configure Git to use GITHUB_TOKEN for private module access
git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

# Build Hugo site
hugo --gc --minify "$@"
