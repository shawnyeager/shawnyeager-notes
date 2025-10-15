# shawnyeager.org

The workshop — notes, observations, and half-formed ideas.

## About

This is the private-but-public notebook side of a two-site system:
- **shawnyeager.org** (this site) — The workshop: rough notes, explorations
- **shawnyeager.com** — The gallery: finished essays

## Design

Both sites share the same design system but serve different purposes. This site uses:
- Short date format (2025 · 01)
- No reading time
- Simple navigation
- Blocked from search engines (intentionally)
- Outlined favicon (represents work in progress)

## Tech Stack

- **Hugo** — Static site generator
- **Custom theme** — No external dependencies
- **System fonts** — Fast, accessible typography
- **CSS variables** — Light/dark mode via system preference

## Local Development

```bash
# Start server
hugo server -D

# Build site
hugo --minify

# Create new note
hugo new content/post/note-title.md
```

## Site Structure

```
shawnyeager.org/
├── content/
│   ├── about.md          # About page
│   └── post/             # All notes
├── layouts/              # Hugo templates
├── static/
│   ├── css/              # Design system
│   └── robots.txt        # Block search engines
└── hugo.toml             # Configuration
```

## Configuration

Key settings in `hugo.toml`:
- Short date format
- Reading time disabled
- Search indexing blocked
- Simple navigation

## Publishing

1. Write note: `hugo new content/post/title.md`
2. Edit the markdown file
3. Build: `hugo --minify`
4. Deploy the `public/` directory

## Design System

Shared with shawnyeager.com:
- Trust Revolution Orange (#F84200)
- System font stack
- Responsive layout (max-width: 700px)
- Light/dark mode support
- Minimal, clean aesthetic

## Philosophy

This site follows the "digital garden" approach — a place to cultivate ideas publicly without the pressure of perfection. Some notes will graduate to finished essays on .com, many won't, and that's the point.

---

**Author:** Shawn Yeager  
**Website:** [shawnyeager.com](https://shawnyeager.com)  
**Nostr:** [nostr.shawnyeager.com](https://nostr.shawnyeager.com)
