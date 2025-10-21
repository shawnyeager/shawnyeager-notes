# shawnyeager.org

[![Netlify Status](https://api.netlify.com/api/v1/badges/68d84b38-f053-46ea-bddd-1dce0c92b393/deploy-status)](https://app.netlify.com/sites/shawnyeager-org/deploys)

**The Workshop** — Notes, observations, and work-in-progress ideas.

## About

This is the workshop side of a two-site system:
- **shawnyeager.org** (this site) — Rough notes and explorations
- **[shawnyeager.com](https://shawnyeager.com)** — Finished essays

Content here is intentionally not indexed by search engines. It's findable if you know about it, but not promoted.

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

- **Hugo** 0.151.0 — Static site generator
- **Hugo Modules** — Theme imported from [tangerine-theme](https://github.com/shawnyeager/tangerine-theme)
- **Netlify** — Automatic deployment on push to master
- **System fonts** — No external dependencies

## Configuration

Key parameters in `hugo.toml`:

```toml
[params]
  content_type = "notes"
  favicon_style = "outlined"      # Outlined square (vs .com's solid)
  noindex = true                  # Block search engines via meta tag
  show_email_signup = false       # No newsletter form
```

## Project Structure

```
shawnyeager-org/
├── content/
│   ├── notes/           # All notes (markdown)
│   └── about.md         # About The Workshop
├── layouts/             # Template overrides
│   ├── index.html       # Custom homepage
│   ├── notes/           # Note-specific layouts
│   └── _default/        # Default layouts
├── hugo.toml            # Site configuration
├── go.mod               # Hugo module config
└── netlify.toml         # Netlify build settings
```

## Theme Module

This site uses the shared **tangerine-theme** via Hugo Modules:

```toml
[module]
  [[module.imports]]
    path = "github.com/shawnyeager/tangerine-theme"
```

For local theme development, switch to:
```toml
path = "/home/shawn/Work/tangerine-theme"
```

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
4. Commit and push: `git push origin master`
5. Netlify auto-deploys to https://shawnyeager.org

## Key Features

- **Year-grouped dates**: Year headings with `Oct · 20` format on lists, full dates on single pages
- **No reading time**: Hidden for workshop aesthetic
- **Search blocking**: `noindex` meta tag (controlled via hugo.toml)
- **Outlined favicon**: Visual metaphor for work-in-progress
- **Clean permalinks**: `/note-slug/` (no `/notes/notes/` duplication)

## Philosophy

The Workshop is for building in public and thinking in public. Notes can be rough, incomplete, or contradictory. Some will graduate to finished essays on .com, many won't — and that's the point.

---

**Author:** Shawn Yeager
**Essays:** [shawnyeager.com](https://shawnyeager.com)
**Nostr:** [nostr.shawnyeager.com](https://nostr.shawnyeager.com)
**GitHub:** [@shawnyeager](https://github.com/shawnyeager)
