# ADR 002: Fuenf Zonen statt Sechs

Datum: 2026-04-12 | Status: accepted | Superseded by: —

## Kontext

Erste Entwuerfe der Meta-Architektur hatten sechs Ordner-Zonen: products/, capital/, clients/, **lab/**, knowledge/, ops/ (plus chronicle als Append-only).

Frage: Ist `lab/` eine eigene ontologische Kategorie oder gehoert sie zu products/?

## Entscheidung

**Fuenf Zonen.** `lab/` loest sich auf in `products/_lab/<experiment>/`.

Die fuenf Zonen:
1. **products/** (inkl. `_lab/` fuer Experimente)
2. **capital/** (blueprints, stack, libs)
3. **clients/**
4. **knowledge/**
5. **ops/** (inkl. chronicle/)

## Begruendung

- Experimente sind **Proto-Produkte**, keine eigene Ontologie. Ein erfolgreiches Experiment wird zum Produkt durch Umbenennen, nicht durch Umzug zwischen Zonen.
- Reduziert kognitive Last: 5 Zonen statt 6.
- Der Flywheel `_lab/ -> capital/ -> products/ -> knowledge/` funktioniert auch mit `products/_lab/`.

## Konsequenz

- `products/_lab/` hat **30-Tage-Halbwertszeit-Regel** — was 30 Tage nicht beruehrt wurde -> archive oder delete
- Erfolgreiche Experimente wandern durch Umbenennen aus `_lab/` nach `products/<slug>/`
- chronicle/ ist kein eigener Top-Level-Ordner mehr, sondern `ops/chronicle/` — Append-only-Charakter bleibt erhalten, aber reduziert Top-Level-Rauschen
