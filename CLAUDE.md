# notes.shawnyeager.com - The Workshop

**Personal notes site for work-in-progress content and thinking in public**

---

## About

**The Workshop** — Rough drafts, half-formed ideas, observations, and notes.

This is where I think in public. Content is intentionally **NOT indexed by search engines** - it's findable if you know about it, but not promoted.

Sister site to **shawnyeager.com** (The Gallery) where polished essays live.

Built with Hugo using the tangerine-theme module.

---

## Quick Start

```bash
# Local development
hugo server -D -p 1316

# Create new note
hugo new content/notes/note-slug.md

# Build for production
hugo --minify
```

---

## Design System

**Always use design tokens, never hardcode values:**

- ✅ `font-size: var(--font-lg);` ❌ `font-size: 18px;`
- ✅ `margin-top: var(--space-xl);` ❌ `margin-top: 32px;`
- ✅ `color: var(--text-primary);` ❌ `color: #1a1a1a;`

Theme tokens defined in tangerine-theme. If a value doesn't have a token, ask before hardcoding.

**Complete documentation:**
- Design system specs: `tangerine-theme/docs/DESIGN_SYSTEM_SPECIFICATION.md`
- Brand messaging: `tangerine-theme/docs/BRAND_MESSAGING_BIBLE.md`

---

## Site Configuration

**NOTE:** Some params are inherited from `tangerine-theme/hugo.toml`:
- `copyright`, `nostr`, `github`, `twitter_handle`, `params.author`
- Hugo automatically merges theme params with site params
- Site params override theme params when both define the same key

Key site-specific parameters in `hugo.toml`:

```toml
[params]
  content_type = "notes"
  favicon_style = "outlined"      # Outlined square (vs .com's solid)
  noindex = false                 # Allow search indexing
  show_email_signup = false       # No newsletter form
  show_read_time = false          # Hide reading time
  secondary_site_url = "https://shawnyeager.com"
  secondary_site_name = "Essays"

[taxonomies]
  topic = "topics"
```

---

## ⚠️ CRITICAL: Search Engine Blocking

**This site MUST remain blocked from search engines.**

The `noindex = true` parameter generates:
```html
<meta name="robots" content="noindex, nofollow">
```

**Always verify after deployment:**
1. View page source
2. Check for robots meta tag in `<head>`
3. Confirm no newsletter form appears

This ensures notes remain findable (via direct link) but not promoted (not in search results).

---

## Notes Frontmatter

```yaml
---
title: "Note Title"
date: 2025-10-15
topics: ["bitcoin", "sales"]     # Optional taxonomy
---
```

Notes use minimal frontmatter - no description field required (unlike essays on .com).

**Date format on site:**
- **Lists:** Year headings with `Oct · 20` format
- **Single pages:** `October 20, 2025` (full spelled-out date)

---

## Image Requirements

**CRITICAL:** All images MUST have descriptive alt text for accessibility.

**Markdown images:**
```markdown
![Descriptive alt text describing the image](image.jpg)
```

**Hugo image shortcode:**
```
{{< image src="image.jpg" alt="Descriptive alt text describing the image" >}}
```

**Alt text best practices:**
- Be descriptive and concise
- Describe what the image shows, not just "image of..."
- For decorative images, use empty `alt=""` (intentional)
- For complex diagrams, consider longer descriptions

**Validation:** The image-validator workflow automatically checks all images for missing alt text on every push.

---

## Page Title Visibility

This site uses smart page title visibility. Individual notes show H1 titles, while utility pages hide them (sr-only for accessibility).

**Visible title pages:**
- Individual notes (automatic)

**Hidden title pages (sr-only):**
- /notes/ listing
- /about (utility page)

To show a page title: add `show_title: true` to frontmatter.

---

## Template Overrides

This site overrides these theme templates in `layouts/`:

- `index.html` - Simple homepage (workshop intro, recent notes)
- `notes/list.html` - Notes index page
- `_default/single.html` - Single note/page template
- `partials/page-title.html` - Page title visibility logic

Templates fall back to tangerine-theme if not overridden locally.

---

## Deployment

**Platform:** Netlify

**Build:**
- Trigger: Push to `master` branch
- Command: `hugo --minify`
- Publish directory: `public/`
- Hugo version: 0.151.0 (set in `netlify.toml`)

**Verification checklist:**
- [ ] Build succeeds
- [ ] No broken links
- [ ] Dark mode works
- [ ] Mobile responsive
- [ ] **noindex = true in hugo.toml** ⚠️
- [ ] Robots meta tag in HTML head ⚠️
- [ ] No newsletter form in footer
- [ ] Footer links to .com (Essays →)
- [ ] Date format: year headings with month · day
- [ ] No reading time shown
- [ ] Outlined orange favicon

---

## Content Structure

```
content/
├── notes/              # Main content (title, date, topics)
└── about.md            # About The Workshop
```

---

## Key Differences from .com

| Feature | .notes (Workshop) | .com (Gallery) |
|---------|-------------------|----------------|
| Purpose | Work in progress | Finished work |
| Search indexing | **Blocked (noindex)** | Allowed |
| Favicon | Outlined square | Solid square |
| Date format | Oct · 20 | October 15, 2025 |
| Reading time | Hidden | Shown |
| Newsletter | Not shown | Shown in footer |
| Homepage | Simple intro | Feature-rich |

---

## Critical Constraints

1. **Never commit `public/` directory** - Build artifact (in `.gitignore`)
2. **Keep noindex = true** ⚠️ - Search engine blocking is core to this site's purpose
3. **Design tokens only** - Never hardcode CSS values
4. **Minimal frontmatter** - Notes don't need descriptions (unlike essays)

---

## Philosophy: The Workshop

This site embodies "building in public" and "thinking in public":

- **No perfection required** - Notes can be rough, incomplete, contradictory
- **Discoverable but not promoted** - Findable via direct link, but not in search
- **Low friction** - Minimal frontmatter, simple structure, quick to publish
- **Outlined favicon** - Visual metaphor for "work in progress"

The Gallery (.com) is where ideas graduate to after they've been refined here in The Workshop.

---

## Theme Updates (Automated - DO NOT TOUCH)

This site automatically updates to the latest tangerine-theme master branch via GitHub Actions.

**⚠️ NEVER manually run `hugo mod get` after theme pushes**

GitHub Actions handles everything:
- Runs `hugo mod get -u` automatically when theme master branch changes
- Commits `go.mod`/`go.sum` changes
- Triggers Netlify deployment

After theme push, only: `git pull` to get automated changes.

**Manual update only if automation fails** (rare - investigate why automation failed first).

**Note:** Theme is public and tracks master branch (no version tags or authentication required).

---

## Related Sites

- **shawnyeager.com** - The Gallery (finished essays)
