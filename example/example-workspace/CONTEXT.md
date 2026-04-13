# blog-platform — CONTEXT

## Zweck

Blog-Plattform fuer Technik-Schreiber, die an Wordpress verzweifeln und Markdown bevorzugen. Loest das Problem schlechter Editor-Experience fuer Code-Blocks, Diagramme und technische Tabellen. Stack: Next.js 14 + MDX + Postgres + Vercel.

## Audience

Primaer: Autor (Betreiber der Plattform). Sekundaer: Claude (bei Feature-Arbeit und Content-Tasks). Tertiaer: Gast-Autoren, die ueber GitHub PRs einreichen.

## Erfolgskriterien

- Drei Live-Autoren veroeffentlichen regelmaessig ohne manuelle Hilfe
- Build-Zeit unter 30s bei 500 Posts
- Onboarding neuer Autoren in unter 1h (von Git-Clone bis erster Post)

## Zu vermeidende Fehler

- **Schroedinger-Posts:** Keine Drafts mit unklarem Status im produktiven Branch — Drafts gehoeren nach `content/_drafts/`
- **Theme-Inflation:** Keine Custom-CSS fuer einzelne Posts — Styles gehoeren zentral in `theme/`
- **Image-Blob:** Keine 5 MB PNGs, die den Build blockieren — Pre-Commit-Hook prueft auf 200 KB Limit

## Aktueller Stand

- Next.js 14 + MDX eingerichtet, Syntax-Highlighting via Shiki
- 12 Live-Posts, zwei Autoren aktiv
- ADR 001 zu "TypeScript statt JavaScript" getroffen
- Dark-Mode aktiv, Light-Mode-Variante in Planung

## Naechster Schritt

RSS-Feed implementieren und Atom-Generator pruefen (Anspruch: alle Posts + Tag-Feeds).
