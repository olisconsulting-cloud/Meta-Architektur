# Meta-Architektur V4 — Die optimale Ordnerstruktur fuer komplexe Projekte

## Kontext

Dieses Dokument ist das Design-Manifest fuer die Meta-Architektur. V4 konsolidiert
die Erkenntnisse aus Skool Quantum Quill Lyceum und aus praktischer Anwendung.
Kern-Entscheidung bei Konflikten: **Skool-Linie (CLAUDE.md als schmaler Router)
hat Vorrang vor File-Engineering-Lehren, die CLAUDE.md als Kontext-reiches
Briefing vorsehen**.

---

## Das zentrale Modell: Drei Schichten

### Schicht 1 — Epistemologie: Drei Wissens-Zustaende

| Zustand | Frage | Beispiele | Regel |
|---------|-------|-----------|-------|
| **Evergreen** | Was gilt jetzt? | CLAUDE.md, CONTEXT.md, REFERENCES.md, GLOSSARY | Waehrend Arbeit aktualisieren |
| **Immutable** | Warum wurde es so? | ADRs, chronicle | Waechst, on-demand gelesen |
| **Ephemeral** | Was tue ich gerade? | Task-Notes, Phase-Context | Stirbt nach Task |

### Schicht 2 — Operatives: Drei-Datei-Architektur (Skool-Standard)

Pro Workspace (Root, Room, Projekt) kanonisches Trio:

| Datei | Zustand | Lade-Verhalten | Inhalt |
|-------|---------|----------------|--------|
| **CLAUDE.md** | Evergreen | **Automatisch** beim Workspace-Entry | Identity + **Routing-Tabelle** + Regeln |
| **CONTEXT.md** | Evergreen | **Task-basiert** via Routing-Tabelle | Zweck, Audience, Erfolgskriterien, Work selbst |
| **REFERENCES.md** | Evergreen tief | **On-Demand** wenn referenziert | Beispiele, Links, Hintergrund |

### Schicht 3 — Ontologie: Fuenf Zonen (sekundaer)

| Zone | Funktion |
|------|----------|
| **products/** | Ausgeliefertes (inkl. `_lab/` fuer Experimente) |
| **capital/** | Wiederverwendbares (blueprints, stack, libs) |
| **clients/** | Kundenprojekte |
| **knowledge/** | Destillierter Lernstoff |
| **ops/** | Tooling, Templates, chronicle |

---

## Der Lade-Mechanismus

**Drei-Stufen-Modell nach Skool:**

```
Stufe 1: CLAUDE.md         -> AUTOMATISCH (beim Workspace-Entry)
Stufe 2: CONTEXT.md        -> TASK-BASIERT (via Routing-Tabelle in CLAUDE.md)
Stufe 3: REFERENCES.md     -> ON-DEMAND (nur wenn explizit referenziert)
```

**Skool-Zitate:**
- *"Every time Claude enters this workspace, it reads this file first."* (CLAUDE.md)
- *"When you tell Claude to work in the Writing Room, it reads the Writing Room context file."* (CONTEXT.md)
- Routing: *"for this task, read these files, skip those files"*

**Konsequenz fuer das Akkumulations-Problem:**
Gesamt-Summe aller CLAUDE.md-Dateien ueber 200 Zeilen zerstoert Instruction-Following
(Accuracy-Einbruch). Skool loest das **automatisch**, weil CONTEXT.md nicht
akkumuliert — sie wird nur geladen wenn gebraucht. CLAUDE.md bleibt dadurch
schmal (Router-Rolle, 40-50 Zeilen), semantische Tiefe lebt in CONTEXT.md ohne
Kontext-Kosten.

**Praktische Regel:**
- CLAUDE.md: max 50 Zeilen (Router)
- CONTEXT.md: so lang wie noetig fuer die Arbeit (wird nur bei Bedarf geladen)
- REFERENCES.md: unbegrenzt (laedt nie von selbst)

---

## Die Pflicht-Routing-Tabelle

Jede CLAUDE.md auf Workspace- oder Zonen-Ebene MUSS eine Routing-Tabelle enthalten.

```markdown
## Routing

| Task-Type | Location | Context File | Skills |
|-----------|----------|--------------|--------|
| Feature-Arbeit      | src/            | CONTEXT.md | — |
| Deployment          | ops/            | CONTEXT.md | — |
| Externe Docs lesen  | .               | REFERENCES.md | — |
```

**Ohne Routing-Tabelle raet Claude** (Skool-Fehler #2). Die Tabelle ist funktional,
nicht Deko.

---

## Rooms (optional, bei >=3 klar unterschiedlichen Mental-Modi)

**Skool-Test:** *"Shifte ich mental mode zwischen diesen Tasks?"* Wenn ja -> Rooms.
Wenn nein -> Subfolders.

```
products/your-project/
|-- CLAUDE.md              # Router zwischen Rooms
|-- CONTEXT.md             # Projekt als Ganzes
|-- REFERENCES.md
|-- rooms/
|   |-- development/
|   |   |-- CLAUDE.md      # nur falls Unique Context
|   |   `-- CONTEXT.md     # Mode-spezifisch
|   |-- deployment/
|   |   `-- CONTEXT.md
|   `-- demo/
|       `-- CONTEXT.md
`-- decisions/
```

**Rooms brauchen keine eigene CLAUDE.md**, ausser sie haben tatsaechlich
Unique-Context-Regeln (Skool-Prinzip: erst bei echter Reibung).

---

## Anti-Patterns

1. **Kategorien-Fehler** (ADR in CLAUDE.md, Historie in README)
2. **CLAUDE.md ohne Routing-Tabelle** -> Claude raet
3. **CONTEXT.md beschreibt Claude statt Arbeit** ("be creative" vs Audience/Constraints)
4. **Zu viele Rooms** (Test: shifte ich mental mode?)
5. **Vorab-Perfektion** (15-Min-Bootstrap, dann evolutiv)
6. **CLAUDE.md-Inflation** (in jedem Subdir eine)
7. **Persona-Leak** (gehoert global, einmal)
8. **Schroedinger-Ordner** (`-v2/`, `-neu/`, `-final/`)
9. **Parkplatz-Ordner** (`misc/`, `Neuer Ordner/`)
10. **Context-Files nie updaten** -> Drift = gefuehlter Faehigkeits-Verlust

---

## Naming-Konventionen

**Ordner:** kebab-case, ASCII-only, max 3 Woerter, Englisch generisch,
Muttersprache nur fuer Eigennamen.

**Dateien:** Kanonisches Trio IMMER Grossbuchstaben (CLAUDE.md, CONTEXT.md,
REFERENCES.md). Working-Files mit Metadata-Suffixen (`_draft`, `_v2`, `YYYY-MM-`).

**Ephemeral context.md (z.B. Phase-Notes)** bleibt kleingeschrieben — visuelle
Trennung zu Evergreen CONTEXT.md.

---

## Living-Document-Disziplin (hoechster Hebel)

**Skool:** Context-Files waehrend Arbeit aktualisieren, nicht monatlich.

- **Micro-Update:** Nach signifikanter Entscheidung -> CONTEXT.md updaten. 30 Sekunden.
- **Macro-Reaping:** Monatlich. chronicle verdichten, alte _lab-Experimente archivieren.

---

## Der 15-Minuten-Bootstrap

Neue Workspaces minimal starten:

```
<workspace>/
|-- CLAUDE.md       # 20 Z.: Identity + 3-Zeilen-Routing
|-- CONTEXT.md      # 10 Z.: Was, fuer wen, Erfolgskriterien
`-- REFERENCES.md   # 5 Z.: initial leer, waechst
```

Wachstum durch Reibung: Erst wenn du zum dritten Mal dasselbe erklaerst -> in
CONTEXT.md.

---

## Verifikation (neuer Workspace)

1. **Lade-Test:** Claude im Ordner starten — laedt er CLAUDE.md? Laedt er
   CONTEXT.md erst bei Task?
2. **Routing-Test:** Task "neue Erkenntnis einpflegen" — findet Claude via
   Routing-Tabelle den richtigen Ort?
3. **Living-Doc-Test:** Letzter Update <7 Tage bei aktiver Arbeit?
4. **Akkumulations-Test:** `wc -l` der CLAUDE.md-Kette bei aktivem Kontext <150 Z.
5. **Inversions-Test nach 2 Wochen:** Waere flacher / Domain-Driven / anderes
   Modell besser gewesen? -> ADR.

---

## Drei-Satz-Manifest

> **1. Struktur = Trennung der drei Wissens-Zustaende (Evergreen / Immutable / Ephemeral).**
>
> **2. Operative Einheit = CLAUDE.md (Router, auto-load) + CONTEXT.md (Arbeit, task-load) + REFERENCES.md (Tiefe, on-demand).**
>
> **3. Hoechster Hebel = Living-Document-Disziplin waehrend der Arbeit.**

---

## Quellen

**Skool Quantum Quill Lyceum (primaer):**
- [Lektion 1.2 — Drei-Datei-Architektur](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=fdee3f73c53b46049078494c0cfb2e54)
- [Lektion 1.3 — Prompt-Struktur](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=05230de8023d463f8d38fddc19152ae2)
- [Lektion 3.1 — Three-Layer Architecture](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=2b4a8ab7461c4f6d828e21c0eb196a6a)
- [Lektion 3.2 — Use-Case-Anpassung](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=1285fe09df7943e79e5d71c68b8b3ccb)
- [Lektion 3.3 — Sieben Fehler](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=7b1919bbe3af42aa859b6060e4e7513f)

**Externe Referenzen:**
- [ADR-Konzept (Michael Nygard)](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- [llms.txt Standard](https://llmstxt.org/)
