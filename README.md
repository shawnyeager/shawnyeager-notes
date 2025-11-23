# notes.shawnyeager.com

[![Netlify Status](https://api.netlify.com/api/v1/badges/68d84b38-f053-46ea-bddd-1dce0c92b393/deploy-status)](https://app.netlify.com/sites/shawnyeager-notes/deploys)
![Version](https://img.shields.io/badge/version-v1.0.0-orange)

**The Workshop** — Notes, observations, and work-in-progress ideas.

## About

This is the workshop side of a two-site system:
- **notes.shawnyeager.com** (this site) — Rough notes and explorations
- **[shawnyeager.com](https://shawnyeager.com)** — Finished essays

## Quick Start

```bash
# Local development
hugo server -D -p 1316

# Create new note
hugo new content/notes/note-slug.md

# Build for production
hugo --minify
```

## Tech Stack

- **Hugo** 0.152.2 — Static site generator
- **Hugo Modules** — Theme imported from [tangerine-theme](https://github.com/shawnyeager/tangerine-theme)
- **Netlify** — Automatic deployment on push to master
- **Inter variable font** — Provided by theme

## Configuration

Key parameters in `hugo.toml`:

```toml
[params]
  content_type = "notes"
  favicon_style = "outlined"      # Outlined square (vs .com's solid)
  noindex = false                 # Optional: set to true to block search engines
  show_email_signup = false       # No newsletter form
```

## Theme

Uses the [tangerine-theme](https://github.com/shawnyeager/tangerine-theme) Hugo module for layouts, CSS, and shared components.

### Local Theme Development

**One-time setup:**
Clone theme as sibling directory:
```bash
cd ~/Work/shawnyeager
git clone git@github.com:shawnyeager/tangerine-theme.git
```

**Daily workflow:**

**Start local development:**
Add this line to `go.mod`:
```
replace github.com/shawnyeager/tangerine-theme => ../tangerine-theme
```

Run hugo server:
```bash
hugo server -D -p 1316
```

Changes to theme appear immediately.

**CRITICAL:** Remove replace directive before committing:
```bash
git restore go.mod
```

**Verify go.mod has no replace directive:**
```bash
git diff go.mod | grep "replace"  # Should return nothing
```

### Deploy Theme Changes

**Sites use PR-based workflow.**

After pushing theme to master:

```bash
# Trigger workflow (or wait for daily cron)
gh workflow run auto-theme-update-pr.yml --repo shawnyeager/shawnyeager-notes

# Check for PR
gh pr list --label theme-update

# Review deploy preview in PR
# Merge when satisfied
```

**DO NOT manually run `hugo mod get`** - workflow handles everything.

## Publishing Workflow

1. Create note: `hugo new content/notes/my-note.md`
2. Edit frontmatter and content:
   ```yaml
   ---
   title: "Note Title"
   date: 2025-10-16
   topics: ["bitcoin", "sales"]
   ---
   ```
3. Preview: `hugo server -D -p 1316`
4. Push to master — Netlify builds and deploys automatically

## Key Features

- **Year-grouped dates**: Year headings with `Oct · 20` format on lists, full dates on single pages
- **No reading time**: Hidden for workshop aesthetic
- **Optional search blocking**: `noindex` parameter available in hugo.toml (currently off)
- **Outlined favicon**: Visual metaphor for work-in-progress
- **Clean permalinks**: `/note-slug/` (no `/notes/notes/` duplication)
- **Smart page titles**: Semantic H1 with visibility controls (see CLAUDE.md for details)

## Philosophy

The Workshop is for building in public and thinking in public. Notes can be rough, incomplete, or contradictory. Some will graduate to finished essays on .com, many won't — and that's the point.
