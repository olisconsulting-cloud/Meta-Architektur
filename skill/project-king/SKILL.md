---
name: project-king
description: Legt einen neuen Workspace nach Meta-Architektur V4 an (Drei-Datei-Architektur CLAUDE+CONTEXT+REFERENCES, _meta.yml, decisions/TEMPLATE.md). Nutze wenn der User einen neuen Workspace, ein neues Projekt, eine neue Zone oder ein neues Blueprint bootstrappen will. Triggert bei "neues Projekt", "neuer Workspace", "bootstrap", "scaffold", "neuen Ordner anlegen", "project-king", "Project-King", "projekt-king", "Projekt-King", "Trio anlegen", "CLAUDE.md und CONTEXT.md fuer neues Projekt". Fuehrt durch 6 Interview-Fragen, kopiert das Template aus dem via install.sh konfigurierten Pfad, ersetzt Platzhalter live, validiert Qualitaet (Routing-Tabelle Pflicht, CLAUDE.md <50 Zeilen) und verankert Living-Document-Disziplin.
---

# Project-King — Neuer Workspace nach Meta-Architektur V4

Dieser Skill bootstrappt einen neuen Workspace nach der Meta-Architektur:
Drei-Datei-Trio (CLAUDE.md Router, CONTEXT.md Arbeit, REFERENCES.md Tiefe) plus
`_meta.yml` plus `decisions/TEMPLATE.md`.

## Kernprinzip

**Qualitaet am Startpunkt > Nachbesserung.** Der Skill fragt live ab, was in
Leer-Platzhalter-Templates oft nie ausgefuellt wird: Zweck, Audience, Task-Types.
Der Skool-Fehler "komplettes System bauen bevor nutzen" wird strukturell geblockt —
der User kann nicht weitermachen ohne Substanz.

## Voraussetzungen

- `install.sh` des Meta-Architektur-Repos wurde einmal ausgefuehrt
- Config-Datei `.config` liegt im Skill-Ordner und enthaelt `META_ARCH_TEMPLATE_PATH`
- Zielordner fuer den neuen Workspace ist im aktuellen Projekt vorgesehen

## Template-Pfad auflösen

Der Skill liest zu Beginn die Datei `.config` im eigenen Skill-Ordner
(`~/.claude/skills/project-king/.config`). Dort steht die Variable:

```
META_ARCH_TEMPLATE_PATH=<absoluter-pfad>/template/project-skeleton
```

Falls `.config` fehlt oder die Variable leer ist: STOPP. Fehlermeldung:

> "Template-Pfad nicht konfiguriert. Fuehre `install.sh` aus dem geklonten
> Meta-Architektur-Repo aus, dann erneut versuchen."

## Workflow

### Phase 0: Ausgangslage klaeren

Bevor das Interview startet, zwei Fragen hintereinander stellen.

**Phase 0.1 — Neu oder bestehend?**

> "Ist das ein **komplett neuer Workspace** oder ein **bestehendes Projekt**,
> das du nach Meta-Architektur strukturieren willst?"

**Bei "neu":** Weiter zu Phase 0.2 — Template wird spaeter in neuen Ordner kopiert.

**Bei "bestehend":** Migrations-Modus aktivieren. Sage:

> "Okay, Migrations-Modus. Ich stelle dir die gleichen 6 Standard-Fragen,
> aber statt Template zu kopieren schreibe ich die drei Kern-Dateien
> (CLAUDE.md + CONTEXT.md + REFERENCES.md) plus _meta.yml direkt in
> deinen bestehenden Ordner. Bestehende Files (src/, tests/, package.json,
> etc.) bleiben unangetastet. `decisions/TEMPLATE.md` wird nur angelegt
> wenn noch kein `decisions/`-Ordner existiert.
>
> Wo liegt dein Projekt-Ordner (absoluter Pfad)?"

Dann weiter zu Phase 0.2.

**Phase 0.2 — Quick-Modus oder Lern-Modus?**

> "Kennst du die Meta-Architektur schon, oder soll ich kurz erklaeren
> was wir tun und warum? (**kenne** / **erklaere**)"

- Antwort `kenne` → **Quick-Modus**: `learn_mode=false`. Phase 1 laeuft wie
  bisher, keine Lernhaeppchen.
- Antwort `erklaere` → **Lern-Modus**: `learn_mode=true`. Vor jeder der
  6 Fragen in Phase 1 wird ein Lernhaeppchen ausgegeben (1 Satz + Pointer).

Keine zusaetzlichen Fragen. Keine Quiz-Elemente. Default ohne Antwort: Quick.

Dann Phase 1 bis Phase 5 durchlaufen. Bei Migrations-Modus zusaetzlich zwei
Unterschiede in Phase 3:

- Ziel-Ordner NICHT neu anlegen (existiert bereits)
- Pro Ziel-File (CLAUDE.md, CONTEXT.md, REFERENCES.md, _meta.yml) pruefen ob
  bereits vorhanden. Falls ja: STOPP, Frage: "Datei <name> existiert bereits.
  Ueberschreiben, ergaenzen, oder abbrechen?" Keine stumme Ueberschreibung.
- `decisions/TEMPLATE.md` nur kopieren wenn `decisions/` fehlt.

### Phase 1: Interview (6 Fragen)

Stelle diese Fragen EINZELN und warte jeweils auf Antwort. Keine Batches.

**Lern-Modus-Regel (fuer alle 6 Fragen):** Wenn `learn_mode=true`, gib VOR
jeder Frage genau einen Satz Essenz + einen Pointer aus. Kein Essay. Kein Quiz.
Wenn `learn_mode=false`, ueberspringe die Lernhaeppchen komplett.

**1. Projekt-Name (kebab-case)**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "Dateinamen kodieren Metadata — kebab-case ist lesbar, kein Tool-Konflikt,
> kein Underscore-Prefix (der ist reserviert fuer `_lab/` und `_meta.yml`).
> Details: `docs/plan-v4.md` Abschnitt _Naming-Konventionen_."

> "Wie soll der Workspace heissen? Konvention: kebab-case, ASCII, max 3 Woerter.
> Beispiele: blog-platform, data-pipeline, mobile-app."

Validierung: nur `[a-z0-9-]+`, keine Leerzeichen, keine Umlaute, keine Unterstriche.
Bei Verletzung: "Bitte kebab-case: [konkreter Gegenvorschlag]."

**2. Zone (5-Zonen-Modell aus ADR 002)**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "Die fuenf Zonen sind ontologisch, keine Arbeitsrolle — wo etwas liegt,
> nicht was man damit tut. Details: `docs/decisions/002-fuenf-zonen-statt-sechs.md`."

> "Welche Zone? products (Ausgeliefertes, inkl. _lab/), capital (Wiederverwendbares —
> Blueprints, Stack, Libs), clients (Kundenprojekte), knowledge (Destilliertes), ops
> (Tooling, Templates, Chronicle). Was passt?"

Gotchas pro Zone (inline zeigen wenn User unsicher ist):

- **products/**: `_lab/`-Experimente haben 30-Tage-Halbwertszeit. Bewaehrte Experimente werden per Umbenennen zu products, nicht per Zonen-Wechsel.
- **capital/**: Blueprint LEHRT, Stack TESTET, Lib WIRD WIEDERVERWENDET — nicht verwechseln.
- **clients/**: Jeder Klient eigenen Ordner, nie Context-Bleed.
- **knowledge/**: Nur Destilliertes, kein Rohmaterial.
- **ops/**: Nur Tools die fuer ALLE Workspaces relevant sind, nicht fuer EINEN.

Validierung: muss eine der 5 sein. Ausnahme: Top-Level-Projekt das eine neue Zone
rechtfertigt → ADR anlegen lassen, nicht einfach durchwinken.

**3. Zweck (2-3 Saetze)**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "CONTEXT.md beschreibt die Arbeit, nicht Claude — Skool-Fehler #4 vermeidet
> Persona-Instruktionen. Details: `docs/skool-zitate.md` Lektion 3.3 Fehler 4."

> "In 2-3 Saetzen: Was tut dieser Workspace? Welches Problem loest er?"

Beispiele:

Gut:
> "Blog-Plattform fuer Technik-Schreiber. Loest das Problem schlechter
> Markdown-Editor-Experience. Stack: Next.js + MDX + Postgres."

Gut (andere Domain):
> "Voice-Agent fuer Telefonie im Kundenservice. Loest Erreichbarkeit
> 24/7 bei kleinen Dienstleistern. Hume EVI + Twilio + n8n."

Zu knapp:
> "Eine Blog-Plattform."

Falsch fokussiert (beschreibt Claude, nicht die Arbeit):
> "Claude soll hier kreativ Blog-Features bauen."

Validierung: Antwort mindestens 40 Zeichen UND enthaelt mindestens ein Verb.
Bei zu kurz: "Das ist zu knapp — formuliere das konkrete Problem und den Loesungsansatz."

**4. Primaere Task-Types (2-3)**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "Die Routing-Tabelle ist Pflicht — ohne sie raet Claude (Skool-Fehler #2).
> Details: `docs/plan-v4.md` Abschnitt _Die Pflicht-Routing-Tabelle_."

> "Nenne 2-3 typische Tasks, die hier stattfinden werden. Daraus baue ich die
> Routing-Tabelle. Format: 'Task-Name | Wo findet es statt | Welche Datei'.
> Eine der Zeilen darf auch auf REFERENCES.md zeigen (externe Quellen
> nachschlagen)."

Beispiele:

Gut:

```
| Blog-Post schreiben  | content/ | CONTEXT.md    | post.mdx |
| Theme anpassen       | theme/   | CONTEXT.md    | —        |
| Externe Docs pruefen | .        | REFERENCES.md | —        |
```

Schlecht (zu vage):

```
| Arbeit an Blog       | .        | CONTEXT.md    | — |
| Andere Arbeit        | .        | CONTEXT.md    | — |
```

Validierung: mindestens 2 Eintraege. Bei 1 Task: "Ein Workspace mit nur einem
Task-Type braucht oft keine eigene CLAUDE.md — ueberleg noch mal ob's 2-3 gibt."

**5. Audience**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "Audience treibt Tiefe, Vokabular, Annahmen — ohne Audience schreibt Claude
> generisch. Details: `skill/project-king/references/bootstrap-questions.md`
> Abschnitt _5. Audience_."

> "Wer arbeitet hier? Primaer (du), sekundaer (Claude), tertiaer (wer noch —
> Kunde, Mitarbeiter, niemand)?"

Validierung: mindestens 2 Ebenen (primaer + sekundaer).

**6. Erfolgskriterien (2-3 Bullets)**

_Lern-Modus-Haeppchen (nur bei `learn_mode=true`):_
> "Kriterium muss in 3 Monaten mit Ja/Nein beantwortbar sein — sonst ist es
> Wunsch, nicht Kriterium. Details: `skill/project-king/references/bootstrap-questions.md`
> Abschnitt _6. Erfolgskriterien_."

> "Woran erkennst du in 3 Monaten, dass dieser Workspace funktioniert? 2-3
> konkrete, wenn moeglich messbare Kriterien. Keine Wunschzettel."

Beispiele:

Gut (konkret, messbar):
- "Drei Live-Autoren veroeffentlichen regelmaessig ohne manuelle Hilfe."
- "Build-Zeit unter 30s bei 500 Posts."
- "Onboarding neuer Autoren in unter 1h."

Wunschzettel (schlecht):
- "Blog ist richtig gut."
- "Autoren sind zufrieden."

Validierung: mindestens 2 Eintraege.

### Phase 2: Bestaetigung vor Write

Zeige dem User eine Zusammenfassung in Tabellen-Form:

```
WORKSPACE-VORSCHAU

Name:          <name>
Zielort:       <zone>/<name>/
Zweck:         <zweck>
Audience:      <audience>
Erfolg:        <erfolg>
Routing:       <2-3 task-types>

Anlegen mit diesen Werten? (j/n)
```

Bei `n`: frage welcher Schritt korrigiert werden soll, nimm die eine Frage erneut.
Bei `j`: weiter zu Phase 3.

### Phase 3: Template kopieren + Platzhalter ersetzen

**Reihenfolge (wichtig):**

1. Pruefe ob Zielordner bereits existiert. Wenn ja → STOPP, nicht ueberschreiben.
2. Lege Zielordner an: `<workspace-root>/<zone>/<name>/`
3. Kopiere alle 5 Dateien aus `$META_ARCH_TEMPLATE_PATH`:
   - CLAUDE.md, CONTEXT.md, REFERENCES.md, _meta.yml, decisions/TEMPLATE.md
4. Ersetze Platzhalter NUR in den 4 Haupt-Files (CLAUDE.md, CONTEXT.md,
   REFERENCES.md, _meta.yml). **`decisions/TEMPLATE.md` bleibt unveraendert** —
   sie ist ADR-Vorlage fuer kuenftige Entscheidungen, kein Projekt-File.
   - `<PROJEKT-NAME>` → gewaehlter Name
   - `YYYY-MM-DD` → heutiges Datum (beide Vorkommen in _meta.yml)
   - `parent-zone: products` → gewaehlte Zone
   - `<Task 1 beschreiben>` ... → erste Task-Type-Zeile
   - `<Task 2 beschreiben>` ... → zweite Task-Type-Zeile
   - `<externe Quelle nachschlagen>` → dritte Task-Type-Zeile (oder leer lassen)
   - CONTEXT.md `<!-- 2-3 Saetze -->` → Zweck-Antwort
   - CONTEXT.md Audience-Platzhalter → Audience-Antwort
   - CONTEXT.md Erfolgskriterien-Bullets → Erfolgs-Antworten
5. In den 4 Haupt-Files alle `<!-- Kommentare -->` loeschen — sie sind nur fuer
   den Template-Leser da, nicht fuer die produktive Datei. In
   `decisions/TEMPLATE.md` bleiben die Kommentare (sie fuehren durch ADRs).

### Phase 4: Qualitaets-Gates

Nach dem Schreiben pruefe:

- `wc -l <workspace>/CLAUDE.md` < 50 → sonst Warnung
- `wc -l <workspace>/CONTEXT.md` < 100 → sonst Warnung
- `grep "<" <workspace>/*.md` → darf nur noch echte Markdown/HTML-Nutzung zeigen,
  keine Platzhalter
- `grep "YYYY-MM-DD" <workspace>/_meta.yml` → muss leer sein
- Routing-Tabelle in CLAUDE.md hat mindestens 2 echte Zeilen

Bei Fehlschlag: zeige konkrete Stelle + Fix-Vorschlag. Nicht stumm weitergehen.

### Phase 5: Abschluss-Ritual

Gib dem User exakt diese vier Ausgaben:

1. **Pfad-Confirmation:** `Workspace angelegt: <absoluter-pfad>`
2. **Optional ADR-Trigger:** "Willst du jetzt eine erste ADR schreiben, warum
   dieser Workspace so geschnitten ist? Vorlage liegt in `decisions/TEMPLATE.md`."
   → Bei `j`: oeffne Template zum Ausfuellen. Bei `n`: weiter.
3. **Living-Document-Reminder:**
   > "Erinnerung: CONTEXT.md nach jeder signifikanten Entscheidung live updaten —
   > das ist der 'highest-leverage habit' nach Skool. Stand und naechster Schritt
   > altern sonst still."
4. **Drei konkrete naechste Schritte:**
   > "Dein Workspace ist bereit. Drei Schritte fuer den Einstieg:
   >
   > 1. Oeffne CONTEXT.md und schreibe in 'Aktueller Stand' den ersten echten Satz.
   > 2. Erster Commit: `git add . && git commit -m 'init: <name>'`
   > 3. Starte mit dem ersten Task aus der Routing-Tabelle."

5. **Optionaler Qualitaets-Check:**
   > "Wenn du die CLAUDE.md noch mal pruefen lassen willst:
   > `/claudemd-optimize` laeuft ein Accuracy-Review nach 8 Prinzipien
   > (Laenge, Redundanz, Routing-Qualitaet, Sprach-Konsistenz).
   > Nicht Pflicht — das Template ist prinzipien-konform. Nur wenn du
   > nach Anpassungen auf Nummer sicher gehen willst."

## Anti-Patterns (vermeiden)

- **Platzhalter stehenlassen.** Jeder `<...>`-Platzhalter muss ersetzt oder die
  Zeile entfernt werden. Nie "fuellt der User spaeter aus".
- **Leere Routing-Tabelle.** Ohne Tabelle raet Claude — Skool-Fehler #2.
  Minimum 2 Zeilen, sonst Abbruch.
- **SYSTEM.md automatisch erzeugen.** Nein, ADR 005 ist eindeutig: erst bei
  Bedarf (>=5 Substanz-Files im Workspace), nicht vorab.
- **decisions/ mit leeren 001-ADRs fuellen.** Nein, TEMPLATE.md reicht bis zur
  ersten echten Entscheidung.
- **Rooms anlegen.** Nein, erst bei echter Modus-Reibung.

## Referenzen

Detail-Hintergrund pro Frage: `references/bootstrap-questions.md` (im Skill-Ordner).

Konzept und Entscheidungen im Meta-Architektur-Repo:
- `docs/plan-v4.md` — Vollversion der Theorie
- `docs/decisions/` — 5 ADRs (Skool-Vorrang, Fuenf Zonen, Trio-Pflicht, kein Trio in artifacts/decisions, SYSTEM.md-Einstieg)
- `docs/glossary.md` — Begriffs-Alignment
- `docs/skool-zitate.md` — Primaerquelle
- `example/example-workspace/` — gebootstrapptes Beispiel zum Angucken
