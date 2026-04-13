# Bootstrap-Interview — Referenz-Script

Nur lesen wenn der User oder Claude zwischen den Fragen einen Detail-Hintergrund
braucht (z.B. "warum 5 Zonen?", "warum kebab-case?"). Gut/Schlecht-Beispiele
liegen direkt in SKILL.md bei den jeweiligen Fragen, nicht hier.

## Frage-Kontexte

### 1. Projekt-Name — Konvention

**Warum kebab-case?** Plan V4 Naming-Konvention: kebab-case, ASCII-only,
max 3 Woerter, Englisch generisch, Muttersprache nur fuer Eigennamen.

**Warum nicht _snake_case?** `_`-Prefix ist reserviert fuer Spezialfaelle wie
`_lab/` (Experimente), `_meta.yml` (Telemetrie). Normale Workspaces haben keinen
Underscore-Prefix.

### 2. Zone — tiefe Details

Die 5 Gotchas pro Zone liegen direkt in SKILL.md Frage 2. Hier nur tiefergehend:

- **products/** — Ausgeliefertes, inkl. `_lab/<experiment>/` fuer Proto-Produkte.
  Bewaehrte Experimente wandern durch Umbenennen, nicht Zonen-Wechsel.
  30-Tage-Halbwertszeit-Regel in `_lab/` ist Praevention, nicht Buerokratie.
- **capital/** — Wiederverwendbares:
  - **Blueprint** = Muster zum Verstehen ("Auth-Flow erklaert")
  - **Stack** = konfigurierte Werkzeugkette ("Next+Tailwind+shadcn-Setup")
  - **Lib** = geteilter Code (Shared Types, Utility-Funktionen)
- **clients/** — Kundenprojekte. Eigene Ordner pro Engagement. Context-Bleed
  zwischen Clients verhindern.
- **knowledge/** — Destilliertes Wissen, Frameworks, Metadocs. Rohmaterial
  gehoert NICHT hier (erst verdichten).
- **ops/** — Tooling, Templates, Chronicle, Reaping-Scripts. Nur was fuer ALLE
  Workspaces relevant ist, nicht fuer EINEN.

**Wann neue Zone statt einer der 5?** Nie leichtfertig. Neue Zone = ADR-pflichtig,
weil sie das Kern-Modell erweitert.

### 3. Zweck — Warum konkret

Skool-Prinzip (Lektion 3.3, Fehler #4): *"Context about the work (audience,
constraints, completed work, success criteria) changes output far more than
personality instructions."*

Zweck muss die Arbeit beschreiben, nicht Claudes Rolle. Gut/Schlecht-Beispiele
in SKILL.md.

### 4. Task-Types — Schema

Jeder Task-Type ergibt eine Routing-Tabellen-Zeile mit Format:

```
| <Task-Type> | <Location> | <Context-File> | <Artefakt> |
```

Beispiele in SKILL.md. Kern-Regel: pro Task klar sein wo er stattfindet und
welche Datei Kontext liefert. Vage Task-Types fuehren zu vage Routing-Entscheidungen.

### 5. Audience — Warum wichtig

Skool-Zitat: *"Context about the work (audience, constraints, completed work,
success criteria) changes output far more than personality instructions."*

Audience-Antwort treibt Tiefe, Vokabular, Annahmen. Ohne Audience schreibt
Claude generisch.

### 6. Erfolgskriterien — Muster

Kern-Unterscheidung: konkret/messbar vs. Wunschzettel. Gut/Schlecht-Beispiele
in SKILL.md. Faustregel: Wenn Kriterium in 3 Monaten nicht mit Ja/Nein
beantwortbar ist, ist es Wunsch, nicht Kriterium.

## Zone-Spezifische Zusatz-Hinweise

**Bei `capital/`:** Frage zusaetzlich: "Blueprint, Stack oder Lib?" → bestimmt
interne Unterordner-Struktur (wird NICHT durch Skill vorab angelegt, nur
dokumentiert in CONTEXT.md).

**Bei `products/_lab/`:** Hinweis ausgeben: "30-Tage-Halbwertszeit-Regel — was
30 Tage nicht beruehrt wird, wird archiviert oder geloescht. Siehe ADR 002."

## Abbruch-Trigger

Skill muss abbrechen mit klarer Meldung, wenn:

- Zielordner existiert bereits **und** Phase 0 war "neu" (im Migrations-Modus
  aus Phase 0 ist existierender Ordner erwartet)
- User will mehr als 1 Workspace auf einmal bootstrappen (ein Task pro Run)
- Template-Pfad (`META_ARCH_TEMPLATE_PATH`) ist leer oder zeigt auf
  nicht-existenten Ordner
