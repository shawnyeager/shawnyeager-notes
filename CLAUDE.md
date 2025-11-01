# notes.shawnyeager.com - The Workshop

**Personal notes site for work-in-progress content and thinking in public**

---

## ⚠️ CRITICAL RULES

**ALWAYS USE DESIGN TOKENS - NEVER HARDCODE VALUES**

- This site uses the tangerine-theme design system built on CSS custom properties
- ALWAYS use tokens for colors, spacing, typography, etc.
- NEVER hardcode pixel values, hex colors, or font weights in templates or styles
- Theme tokens are defined in `tangerine-theme/static/css/main.css` lines 11-107
- Examples:
  - ✅ `font-size: var(--font-lg);`
  - ❌ `font-size: 18px;`
  - ✅ `margin-top: var(--space-xl);`
  - ❌ `margin-top: 32px;`
  - ✅ `color: var(--text-primary);`
  - ❌ `color: #1a1a1a;`
- If a value doesn't have a token, ask before creating overrides
- Site-specific overrides should be minimal - prefer theme changes

---

## Purpose

The Workshop: Rough drafts, half-formed ideas, observations, and notes. This is where I think in public. Content is intentionally NOT indexed by search engines - it's findable if you know about it, but not promoted.

## Repository Structure

```
shawnyeager-notes/
├── CLAUDE.md                    # This file
├── hugo.toml                    # Site configuration
├── go.mod                       # Hugo Modules config
├── content/
│   ├── notes/                   # Notes and observations
│   └── about.md                 # About The Workshop
├── layouts/
│   ├── index.html               # Simple homepage
│   ├── notes/                   # Note-specific layouts
│   ├── _default/                # Default layouts
│   └── partials/                # Partial overrides
├── static/                      # Static files (currently empty)
└── public/                      # Built site (not committed)
```

## Theme Module

This site imports the shared theme:

```toml
[module]
  [[module.imports]]
    path = "github.com/shawnyeager/tangerine-theme"  # Always use GitHub URL
```

**Local development:** The `~/Work/hugo.work` file automatically redirects to your local theme directory. No config changes needed! Just edit the theme and changes appear immediately.

**Production (Netlify):** Fetches from GitHub at the version locked in `go.mod`.

## ⚠️ CRITICAL: Hugo Module Management

### Why This Matters

This site uses Hugo Modules to import the tangerine-theme. A **workspace file** (`/home/shawn/Work/hugo.work`) is set up to redirect module imports locally during development, BUT `hugo mod tidy` removes the `require` statement from go.mod because it sees the module as satisfied by the workspace. This breaks Netlify builds which don't have hugo.work.

### Local Development (Current Setup)

The workspace is **already configured** at `/home/shawn/Work/hugo.work`. This means:

1. **hugo.toml always uses GitHub URL**:
```toml
[module]
  [[module.imports]]
    path = "github.com/shawnyeager/tangerine-theme"  # Production URL
```

2. **hugo.work redirects locally** to `/home/shawn/Work/tangerine-theme` during development

3. **Just run normally**:
```bash
hugo server -D -p 1316          # Works with local theme via hugo.work
hugo --minify                     # Builds with local theme
```

4. **NEVER run**: `hugo mod tidy` (this removes the require statement!)

### Updating Theme Version

When the theme is updated:

```bash
# Update to latest version
hugo mod get github.com/shawnyeager/tangerine-theme@latest

# Verify go.mod updated
grep "require github.com/shawnyeager/tangerine-theme" go.mod

# Test build locally
hugo --minify

# Pre-commit hook validates this automatically
git add go.mod && git commit -m "chore: update tangerine-theme to v1.18.6"
```

### Why hugo.work Exists

The workspace file allows local development on the theme while keeping the GitHub URL in `hugo.toml`. This solves the critical problem: Netlify doesn't have `hugo.work`, so it needs the explicit `require` statement in go.mod to fetch the theme from GitHub.

- **Local:** hugo.work redirects → local theme at `/home/shawn/Work/tangerine-theme`
- **Production:** go.mod require → fetches from GitHub

### Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `hugo: WARN Module not found` | URL misspelled or version wrong | Check module path spelling in hugo.toml |
| Netlify build fails but local works | go.mod missing require statement | Run `hugo mod get github.com/shawnyeager/tangerine-theme@latest` |
| Changes to theme don't appear | Theme not at expected local path | Verify `/home/shawn/Work/tangerine-theme` exists and is up to date |
| `hugo mod tidy` removes require | Hugo workspace redirecting | Never run `hugo mod tidy` when `/home/shawn/Work/hugo.work` exists |

**Automated safeguards:**
- Pre-commit hook validates go.mod has theme require
- GitHub Actions CI validates module requirements on push

## Site Configuration

Key settings in `hugo.toml`:

```toml
baseURL = "https://notes.shawnyeager.com/"
title = "Shawn's Notes"

[params]
  content_type = "notes"
  favicon_style = "outlined"      # Outlined square (vs .com's solid)
  noindex = true                  # Block search engines via meta tag
  show_email_signup = false       # No newsletter form
  show_read_time = false          # Hide reading time
  description = "Building in public - notes and explorations"
  secondary_site_url = "https://shawnyeager.com"
  secondary_site_name = "Essays"

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
topics: ["bitcoin", "sales"]     # Optional taxonomy
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
   - Recent notes list
   - Link to "All notes"

2. **`layouts/notes/list.html`**: Notes index page

3. **`layouts/_default/single.html`**: Single note/page template

4. **`layouts/partials/page-title.html`**: Smart page title visibility logic (see below)

Templates fall back to theme module if not overridden locally.

## Page Title Visibility System

All page templates use the `page-title.html` partial for semantic H1 titles with smart visibility:

**Logic:**
- **Notes (individual):** Type=notes AND Kind!=section → Show H1 title (visible)
- **Notes section listing:** Type=notes AND Kind=section → Hide H1 title (sr-only)
- **Pages (with show_title flag):** Frontmatter `show_title: true` → Show H1 title (visible)
- **Pages (default):** No show_title flag → Hide H1 title (sr-only)

**In templates:** Use `{{ partial "page-title.html" . }}`

**In frontmatter:** Add `show_title: true` to show page title visually

**Current visible title pages:**
- Individual notes (automatic via type)

**Current hidden title pages (utility pages):**
- /notes/ listing (section type)
- /about (utility page)

**Reference:** See `layouts/partials/page-title.html` for implementation details.

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
cd ~/Work/shawnyeager-notes

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

## One-time Setup After Cloning

After cloning this repo on a new machine, run:

```bash
./scripts/setup.sh
```

This configures:
- Git hooks (symlinked to shared-workflows/git-hooks/pre-commit)
- Verifies mise tools are installed (hugo-extended)

**What the pre-commit hook fixes automatically:**

*Markdown formatting (via markdownlint-cli2):*
- MD009: Trailing spaces
- MD010: Hard tabs
- MD012: Multiple blank lines
- MD018/019: Heading spacing
- MD023: Indented headings
- MD047: Missing trailing newline
- Plus 25+ other fixable rules (respects `.markdownlint.json`)

*Smart punctuation (custom cleanup - BODY CONTENT ONLY):*
- Curly apostrophes (') → straight apostrophes (')
- Curly quotes ("") → straight quotes ("")
- Em dashes (—) → triple hyphens (---)
- En dashes (–) → double hyphens (--)
- Ellipsis (…) → three periods (...)
- **IMPORTANT:** Frontmatter is NOT modified (preserves smart punctuation in descriptions)

The hook runs on staged `.md` files only, skips YAML frontmatter, shows what it fixed in body content, and re-stages changes. This is especially useful when copying notes from Obsidian or other external sources.

**Hook updates are automatic:** The hook is symlinked to shared-workflows. When the shared hook updates, changes apply immediately on your next commit - no need to re-run setup.sh!

**Note:** The hook prevents CI failures from hardcoded smart punctuation in body content while preserving it in frontmatter, keeping full visibility into what changed.

## Design System

**Same as .com** - both sites share the complete design system from the theme.

Only differences:
- Date format: Year headings + Oct · 20 vs Full spelled-out
- No reading time shown
- Simpler homepage
- No newsletter form in footer
- Outlined favicon vs solid

## Key Differences from .com

| Feature | notes subdomain (Workshop) | .com (Gallery) |
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

**Custom domain:** notes.shawnyeager.com

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

The Gallery (.com) is where ideas graduate to after they've been refined here in The Workshop (notes subdomain).

## Notes

- Never commit `public/` directory (in `.gitignore`)
- No analytics needed (this is the workshop)
- Outlined orange favicon differentiates from .com's solid favicon
- `noindex` parameter is critical - always verify meta tag after deployment
- Feel free to be messy here - that's the point
