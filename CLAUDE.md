# shawnyeager.org - The Workshop

**Personal notes site for work-in-progress content and thinking in public**

## Purpose

The Workshop: Rough drafts, half-formed ideas, observations, and notes. This is where I think in public. Content is intentionally NOT indexed by search engines - it's findable if you know about it, but not promoted.

## Repository Structure

```
shawnyeager-org/
├── CLAUDE.md                    # This file
├── hugo.toml                    # Site configuration
├── go.mod                       # Hugo Modules config
├── content/
│   ├── notes/                   # Notes and observations
│   └── about.md                 # About The Workshop
├── layouts/
│   ├── index.html               # Simple homepage
│   └── partials/
│       ├── head.html            # Outlined favicon override
│       └── footer.html          # No newsletter override
├── static/                      # Static files (currently empty)
└── public/                      # Built site (not committed)
```

## Theme Module

This site imports the shared theme:

```toml
[module]
  [[module.imports]]
    path = "github.com/shawnyeager/tangerine-theme"  # Production
    # path = "/home/shawn/Work/tangerine-theme"      # Local testing
```

**For local development:** Use local path
**For production:** Use GitHub URL

## Site Configuration

Key settings in `hugo.toml`:

```toml
baseURL = "https://shawnyeager.org/"
title = "Shawn's Notes"

[params]
  show_read_time = false          # Hide reading time
  description = "Building in public - notes and explorations"
  primary_site_url = "https://shawnyeager.com"
  primary_site_name = "Essays"

[taxonomies]
  topic = "topics"                # Browse notes by topic (if used)
```

## Content Structure

### Notes (`content/notes/`)

Markdown files with minimal frontmatter:

```yaml
---
title: "Note Title"
date: 2025-10-15
---

Note content here...
```

**Date format on site:**
- **Lists:** Year headings with `Oct · 20` format for notes
- **Single pages:** `October 20, 2025` (full spelled-out date)

### Special Pages

- **`about.md`**: Explains the Gallery/Workshop philosophy

## Template Overrides

This site overrides these theme templates:

1. **`layouts/index.html`**: Simple homepage with:
   - Workshop intro text
   - Recent notes list (7 items)
   - Link to "All notes"

2. **`layouts/partials/head.html`**: Outlined orange square favicon (The Workshop metaphor)

3. **`layouts/partials/footer.html`**: No newsletter form, only links:
   - Nostr
   - GitHub
   - Essays → (links to .com)
   - Email

## Search Engine Blocking

**Critical:** Search engines are blocked via the `noindex` parameter in `hugo.toml`:

```toml
[params]
  noindex = true  # Blocks search engines via robots meta tag
```

The theme generates `<meta name="robots" content="noindex, nofollow">` when this is set to `true`.

This ensures notes remain findable but not promoted.

## Common Tasks

### Publishing a New Note

```bash
cd ~/Work/shawnyeager-org

# Create new note
hugo new content/notes/note-slug.md

# Edit the file
# Add title, date
# Write content (can be rough!)

# Preview locally
hugo server -D -p 1316
# View at http://localhost:1316

# Build
hugo --minify

# Deploy (push to GitHub, Netlify builds automatically)
git add content/notes/note-slug.md
git commit -m "Add note: Title"
git push
```

### Updating About Page

```bash
# Edit content/about.md

hugo --minify
git add content/about.md
git commit -m "Update about page"
git push
```

## Design System

**Same as .com** - both sites share the complete design system from the theme.

Only differences:
- Date format: Year headings + Oct · 20 vs Full spelled-out
- No reading time shown
- Simpler homepage
- No newsletter form in footer
- Outlined favicon vs solid

## Key Differences from .com

| Feature | .org (Workshop) | .com (Gallery) |
|---------|-----------------|----------------|
| Purpose | Work in progress | Finished work |
| Date format | Year headings + Oct · 20 | October 15, 2025 |
| Reading time | Hidden | Shown |
| Homepage | Simple intro | Feature-rich |
| Newsletter | Not shown | Shown in footer |
| Search indexing | **Blocked** | Allowed |
| Favicon | **Outlined square** | Solid square |
| Footer links | 4 links + Essays → | 5 links + Notes → |

## Testing Checklist

Before deploying:
- [ ] Build succeeds: `hugo --minify`
- [ ] No broken links
- [ ] Dark mode works
- [ ] Mobile responsive
- [ ] **noindex = true in hugo.toml** (blocks search engines)
- [ ] Robots meta tag present in HTML head
- [ ] No newsletter form in footer
- [ ] Footer links to .com (Essays →)
- [ ] Date format uses year headings with month · day on lists
- [ ] No reading time shown

## Deployment

**Platform:** Netlify

**Build settings:**
- Build command: `hugo --minify`
- Publish directory: `public`
- Hugo version: 0.151.0 (set in `netlify.toml` or environment)

**Custom domain:** shawnyeager.org

**Deploy:**
```bash
git push origin master
# Netlify automatically builds and deploys
```

**Post-deploy verification:**
1. View page source and verify robots meta tag: `<meta name="robots" content="noindex, nofollow">`
2. Confirm no newsletter form appears
3. Check date format uses year headings with Oct · 20 format on lists

## Related Repositories

- **tangerine-theme**: Shared theme module
  - `github.com/shawnyeager/tangerine-theme`
  - Contains layouts, CSS, partials

- **shawnyeager-com**: The Gallery (professional site)
  - `github.com/shawnyeager/shawnyeager-com`
  - Sister site for finished essays

## Archived Monorepo

Original development happened in: `~/Work/hugo-sites-project`

Contains:
- Design system specification: `docs/design-system-specification.md`
- HTML mockups: `docs/shawnyeager-org-mockup.html`
- Original templates and CSS
- Full project history

**Reference for:** Design decisions, mockups, specifications

## Philosophy: The Workshop

This site embodies "building in public" and "thinking in public":

- **No perfection required**: Notes can be rough, incomplete, contradictory
- **Discoverable but not promoted**: Findable via direct link, but not in search
- **Low friction**: Minimal frontmatter, simple structure, quick to publish
- **Outlined favicon**: Visual metaphor for "work in progress" vs .com's "finished work"

The Gallery (.com) is where ideas graduate to after they've been refined here in The Workshop (.org).

## Notes

- Never commit `public/` directory (in `.gitignore`)
- No analytics needed (this is the workshop)
- Outlined orange favicon differentiates from .com's solid favicon
- `noindex` parameter is critical - always verify meta tag after deployment
- Feel free to be messy here - that's the point
