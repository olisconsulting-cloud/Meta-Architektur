# blog-platform — Router

Blog-Plattform fuer Technik-Schreiber. Markdown-first, Next.js + MDX + Postgres.

## Routing

| Task-Type | Location | Context | Artefakt |
|-----------|----------|---------|----------|
| Neuer Blog-Post | content/posts/ | CONTEXT.md | post.mdx |
| Theme-Arbeit | theme/ | CONTEXT.md | — |
| Externe Quellen (Next.js, MDX) | . | REFERENCES.md | — |
| Architektur-Entscheidung | decisions/ | — | NNN-titel.md (ADR) |

## Regeln

- Alle Posts in MDX, kein Rich-Text-Editor
- Images unter 200 KB, WebP bevorzugt
- Dark-Mode-Default (Design-Entscheidung aus ADR 001)
