# ADR 001: TypeScript statt JavaScript

Datum: 2026-02-20 | Status: accepted | Superseded by: —

## Kontext

Beim Setup der Blog-Plattform stand die Frage: reines JavaScript (schneller Start, weniger Boilerplate) oder TypeScript (Typ-Sicherheit, bessere Tool-Unterstuetzung in IDEs).

Die Plattform soll mehrere Autoren integrieren (via GitHub PRs). Typfehler in MDX-Frontmatter oder in Shared-Components koennten bei Unerfahrenen still durchrutschen und spaeter zu Build-Fails fuehren.

## Entscheidung

**TypeScript komplett, auch in MDX-Frontmatter-Schema.**

Konkret:
- `tsconfig.json` mit strict-mode
- Zod-Schema fuer Post-Frontmatter (Titel, Datum, Tags, Zusammenfassung)
- Shared-Components haben explizite Props-Interfaces

## Begruendung

- Typfehler fruehzeitig bei Autor-PRs sichtbar, nicht erst im Build
- IDE-Autocomplete fuer Theme-Variablen spart spuerbar Zeit
- Initial-Overhead ~2h fuer Setup, amortisiert nach 5 Posts
- Gast-Autoren mit JS-Hintergrund koennen trotzdem einfache Posts schreiben — nur Frontmatter muss schema-konform sein

## Konsequenz

- Keine `.js`-Dateien ausserhalb von `node_modules/`
- Pre-Commit-Hook: `tsc --noEmit` muss durchlaufen
- Dokumentation fuer Gast-Autoren: Zod-Schema als Referenz fuer gueltige Frontmatter-Struktur
