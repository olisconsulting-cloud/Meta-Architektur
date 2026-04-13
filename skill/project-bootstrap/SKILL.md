---
name: project-bootstrap
description: Legt einen neuen Workspace nach Meta-Architektur V4 an (Drei-Datei-Architektur CLAUDE+CONTEXT+REFERENCES, _meta.yml, decisions/TEMPLATE.md). Nutze wenn der User einen neuen Workspace, ein neues Projekt, eine neue Zone oder ein neues Blueprint bootstrappen will. Triggert bei "neues Projekt", "neuer Workspace", "bootstrap", "scaffold", "neuen Ordner anlegen", "project-bootstrap", "Trio anlegen", "CLAUDE.md und CONTEXT.md fuer neues Projekt". Fuehrt durch 6 Interview-Fragen, kopiert das Template aus dem via install.sh konfigurierten Pfad, ersetzt Platzhalter live, validiert Qualitaet (Routing-Tabelle Pflicht, CLAUDE.md <50 Zeilen) und verankert Living-Document-Disziplin.
---

# project-bootstrap — Neuer Workspace nach Meta-Architektur V4

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
(`~/.claude/skills/project-bootstrap/.config`). Dort steht die Variable:

```
META_ARCH_TEMPLATE_PATH=<absoluter-pfad>/template/project-skeleton
```

Falls `.config` fehlt oder die Variable leer ist: STOPP. Fehlermeldung:

> "Template-Pfad nicht konfiguriert. Fuehre `install.sh` aus dem geklonten
> Meta-Architektur-Repo aus, dann erneut versuchen."

## Workflow

### Phase 1: Interview (6 Fragen)

Stelle diese Fragen EINZELN und warte jeweils auf Antwort. Keine Batches.

**1. Projekt-Name (kebab-case)**
> "Wie soll der Workspace heissen? Konvention: kebab-case, ASCII, max 3 Woerter.
> Beispiele: blog-platform, data-pipeline, mobile-app."

Validierung: nur `[a-z0-9-]+`, keine Leerzeichen, keine Umlaute, keine Unterstriche.
Bei Verletzung: "Bitte kebab-case: [konkreter Gegenvorschlag]."

**2. Zone (5-Zonen-Modell aus ADR 002)**
> "Welche Zone? products (Ausgeliefertes, inkl. _lab/), capital (Wiederverwendbares —
> Blueprints, Stack, Libs), clients (Kundenprojekte), knowledge (Destilliertes), ops
> (Tooling, Templates, Chronicle). Was passt?"

Validierung: muss eine der 5 sein. Ausnahme: Top-Level-Projekt das eine neue Zone
rechtfertigt → ADR anlegen lassen, nicht einfach durchwinken.

**3. Zweck (2-3 Saetze)**
> "In 2-3 Saetzen: Was tut dieser Workspace? Welches Problem loest er?"

Validierung: Antwort mindestens 40 Zeichen UND enthaelt mindestens ein Verb.
Bei zu kurz: "Das ist zu knapp — formuliere das konkrete Problem und den Loesungsansatz."

**4. Primaere Task-Types (2-3)**
> "Nenne 2-3 typische Tasks, die hier stattfinden werden. Daraus baue ich die
> Routing-Tabelle. Format: 'Task-Name | Wo findet es statt | Welche Datei'.
> Beispiel: 'Bug fixen | src/ | CONTEXT.md'. Eine der Zeilen darf auch auf
> REFERENCES.md zeigen (externe Quellen nachschlagen)."

Validierung: mindestens 2 Eintraege. Bei 1 Task: "Ein Workspace mit nur einem
Task-Type braucht oft keine eigene CLAUDE.md — ueberleg noch mal ob's 2-3 gibt."

**5. Audience**
> "Wer arbeitet hier? Primaer (du), sekundaer (Claude), tertiaer (wer noch —
> Kunde, Mitarbeiter, niemand)?"

Validierung: mindestens 2 Ebenen (primaer + sekundaer).

**6. Erfolgskriterien (2-3 Bullets)**
> "Woran erkennst du in 3 Monaten, dass dieser Workspace funktioniert? 2-3
> konkrete, wenn moeglich messbare Kriterien. Keine Wunschzettel."

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

Gib dem User exakt diese drei Ausgaben:

1. **Pfad-Confirmation:** `Workspace angelegt: <absoluter-pfad>`
2. **Optional ADR-Trigger:** "Willst du jetzt eine erste ADR schreiben, warum
   dieser Workspace so geschnitten ist? Vorlage liegt in `decisions/TEMPLATE.md`."
   → Bei `j`: oeffne Template zum Ausfuellen. Bei `n`: weiter.
3. **Living-Document-Reminder:**
   > "Erinnerung: CONTEXT.md nach jeder signifikanten Entscheidung live updaten —
   > das ist der 'highest-leverage habit' nach Skool. Stand und naechster Schritt
   > altern sonst still."

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
