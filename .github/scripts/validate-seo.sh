#!/bin/bash

# Content Validator for Hugo notes
# Checks that all notes have required frontmatter fields
# Lighter validation than the essays site since notes are informal

# Note: Not using set -e to allow script to continue on errors

ERRORS=0
WARNINGS=0

echo "🔍 Validating frontmatter for notes..."
echo ""

# Find all markdown files in content/notes/ (excluding _index.md)
while IFS= read -r -d '' file; do
  # Skip _index.md files (Hugo list pages)
  if [[ "$file" == *"_index.md" ]]; then
    continue
  fi

  echo "Checking: $file"

  # Extract frontmatter (between --- markers)
  FRONTMATTER=$(awk '/^---$/{i++}i==1' "$file" | sed '1d;$d')

  # Check for required fields

  # Title (required)
  if ! echo "$FRONTMATTER" | grep -q "^title:"; then
    echo "  ❌ Missing: title"
    ((ERRORS++))
  fi

  # Date (required)
  if ! echo "$FRONTMATTER" | grep -q "^date:"; then
    echo "  ❌ Missing: date"
    ((ERRORS++))
  fi

  # Description (optional for notes since noindex=true)
  # Just a gentle reminder if missing
  if ! echo "$FRONTMATTER" | grep -q "^description:"; then
    echo "  ℹ️  Note: No description (optional for notes)"
  fi

  # Topics (optional but recommended)
  HAS_TOPICS=$(echo "$FRONTMATTER" | grep -c "^topics:" || true)

  if [ $HAS_TOPICS -eq 0 ]; then
    echo "  ℹ️  Note: No topics (optional for notes)"
  fi

  # Check if draft
  if echo "$FRONTMATTER" | grep -q "^draft: true"; then
    echo "  ℹ️  Draft (skipping publish checks)"
  fi

  echo ""

done < <(find content/notes -name "*.md" -type f -print0 2>/dev/null)

# Summary
echo "================================"
echo "Summary:"
echo "  Errors: $ERRORS"
echo "  Warnings: $WARNINGS"
echo "================================"

if [ $ERRORS -gt 0 ]; then
  echo "❌ Validation failed with $ERRORS errors"
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "⚠️  Validation passed with $WARNINGS warnings"
  exit 0
else
  echo "✅ All notes pass validation"
  exit 0
fi
