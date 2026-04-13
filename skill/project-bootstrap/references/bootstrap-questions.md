# Bootstrap-Interview — Referenz-Script

Nur lesen wenn der User oder Claude zwischen den Fragen einen Detail-Hintergrund
braucht (z.B. "warum 5 Zonen?", "was ist Routing-Tabelle?"). Sonst folgt Claude
direkt SKILL.md Phase 1.

## Frage-Kontexte

### 1. Projekt-Name

**Warum kebab-case?** Plan V4 Naming-Konvention: kebab-case, ASCII-only,
max 3 Woerter, Englisch generisch, Muttersprache nur fuer Eigennamen.

**Warum nicht _snake_case?** `_`-Prefix ist reserviert fuer Spezialfaelle wie
`_lab/` (Experimente), `_meta.yml` (Telemetrie). Normale Workspaces haben keinen
Underscore-Prefix.

### 2. Zone — Details

- **products/** — Ausgeliefertes, inkl. `_lab/<experiment>/` fuer Proto-Produkte.
  Bewaehrte Experimente wandern durch Umbenennen, nicht Zonen-Wechsel.
- **capital/** — Wiederverwendbares: Blueprints (Muster zum Verstehen), Stack
  (konfigurierte Werkzeugketten), Libs (geteilter Code).
- **clients/** — Kundenprojekte. Eigene Ordner pro Engagement.
- **knowledge/** — Destilliertes Wissen, Frameworks, Metadocs.
- **ops/** — Tooling, Templates, Chronicle, Reaping-Scripts.

**Wann neue Zone statt einer der 5?** Nie leichtfertig. Neue Zone = ADR-pflichtig,
weil sie das Kern-Modell erweitert.

### 3. Zweck — was gilt als gut

Zu knapp: "Eine Blog-Plattform."
Ausreichend: "Blog-Plattform fuer Technik-Schreiber. Loest das Problem,
dass viele Autoren an Wordpress verzweifeln und Markdown bevorzugen.
Stack: Next.js, MDX, Postgres."

Schlecht weil Claude-fokussiert: "Claude soll hier kreativ Blog-Features bauen."
(Skool-Fehler #4 — Context beschreibt Claude, nicht die Arbeit.)

### 4. Task-Types — Schema

Jeder Task-Type ergibt eine Routing-Tabellen-Zeile mit Format:
```
| <Task-Type> | <Location> | <Context-File> | <Artefakt> |
```

Beispiele:
```
| Blog-Post schreiben  | content/ | CONTEXT.md | post.mdx |
| Theme-Arbeit         | theme/   | CONTEXT.md | — |
| Externe Docs lesen   | .        | REFERENCES.md | — |
```

### 5. Audience — Warum wichtig

Skool-Zitat (Lektion 3.3, Fehler #4): *"Context about the work (audience,
constraints, completed work, success criteria) changes output far more than
personality instructions."*

Audience-Antwort treibt Tiefe, Vokabular, Annahmen. Ohne Audience schreibt
Claude generisch.

### 6. Erfolgskriterien — Muster

Gut (konkret, oft messbar):
- "Drei Live-Autoren veroeffentlichen regelmaessig ohne manuelle Hilfe."
- "Build-Zeit unter 30s bei 500 Posts."
- "Onboarding neuer Autoren in unter 1h."

Schlecht (Wunschzettel):
- "Der Blog ist richtig gut."
- "Autoren sind zufrieden."
- "Wir lernen viel."

## Zone-Spezifische Hinweise

**Bei `capital/`:** Frage zusaetzlich: "Blueprint, Stack oder Lib?" → bestimmt
interne Unterordner-Struktur (wird NICHT durch Skill vorab angelegt, nur
dokumentiert in CONTEXT.md).

**Bei `products/_lab/`:** Hinweis ausgeben: "30-Tage-Halbwertszeit-Regel — was
30 Tage nicht beruehrt wird, wird archiviert oder geloescht. Siehe ADR 002."

## Abbruch-Trigger

Skill muss abbrechen mit klarer Meldung, wenn:

- Zielordner existiert bereits (Schroedinger-Ordner vermeiden)
- User will mehr als 1 Workspace auf einmal bootstrappen (ein Task pro Run)
- Template-Pfad (`META_ARCH_TEMPLATE_PATH`) ist leer oder zeigt auf nicht-existenten Ordner
