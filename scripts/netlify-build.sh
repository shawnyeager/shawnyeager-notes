#!/bin/bash
set -e

# Build Hugo site
hugo --gc --minify "$@"
