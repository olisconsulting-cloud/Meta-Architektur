# Skool Quantum Quill Lyceum — Kern-Zitate und Lektions-Inhalte

Primaerquelle fuer die Meta-Architektur. On-Demand lesen bei Struktur-Entscheidungen.

---

## Lektion 1.2 — Die Drei-Datei-Architektur

Das kanonische Trio pro Workspace:

### CLAUDE.md
> "Identity - You are helping [YOUR NAME] with [WHAT YOU DO]" mit Verhaltensregeln.

Definiert Rolle und Kommunikationsprinzipien.

### CONTEXT.md
Drei Abschnitte:
- Projektbeschreibung (2-3 Saetze)
- Definition von "gute Arbeit"
- Zu vermeidende Fehler

### REFERENCES.md
> "Background material. Examples, links, notes, anything Claude should know about"

Beispiele, URLs, Notizen ohne direkte Handlungsaufforderung.

### Lade-Mechanismus

**Claude Code (Terminal):**
> "Navigate to the folder, type `claude`. It reads the files automatically."

**Claude Browser:**
1. Projects-Funktion: *"Create a Project, upload your three files as Project Knowledge, and start a conversation inside that Project. Claude references them in every message."*
2. Manuell: *"Copy the contents of all three files and paste them at the top of your first message."*

---

## Lektion 1.3 — Prompt-Struktur + Folder-Memory

### Fuenf Teile eines strukturierten Prompts

1. **Identity** — Rolle zugewiesen (formt Vokabular, Tiefe, Annahmen)
2. **Task** — klare Aktion + definierter Umfang + ausreichend Detail
3. **Context** — *"Background. The constraints. The audience. Prior decisions. Relevant data."*
4. **Constraints** — *"Telling Claude what you do NOT want is just as useful as telling it what you do want."*
5. **Output Format** — *"Tell Claude the shape of the answer. A list? A table? Three options?"*

### Kern-Satz zur Folder-Architektur

> "The folder is memory. The prompt is direction. They work together."

- CLAUDE.md = persistente Identity + Projekt-Kontinuitaet
- CONTEXT.md = Projekt-Level
- Individuelle Prompts = Task, Constraints, Output-Format pro Anfrage

### Chunking

- **Aufgaben-Chunking:** *"Each prompt should ask for one clear thing."*
- **Daten-Chunking:** Struktur ankuendigen, Abschnitte einzeln eingeben, dann cross-anfragen.

---

## Lektion 3.1 — Three-Layer Architecture

### Layer 1: The Map (CLAUDE.md)
> "tells the AI: for this task, read these files, skip those files, you might need these skills"

- Oberste Datei am Projektroot
- Definiert: Projektidentitaet, Ordnerstruktur, Namenskonventionen, Dateiablage
- **Zentrale Routing-Tabelle fuer AI-Navigation**

### Layer 2: The Rooms (Workspace Context Files)
- Separate Kontextdateien pro Arbeitsbereich
- Workspace-Zweck, Prozessschritte, Dateiorganisation, erforderliche Skills
- **Laden nur relevante Informationen fuer aktuelle Aufgabe**
- Beispiel: Writing Room vs. Production vs. Community

### Layer 3: The Tools (Skills & Plug-and-Play)
- Prozess-Pakete fuer spezifische Aufgaben
- Nur workspace-relevante Skills werden geladen
- Skalierung ohne Token-Verschwendung

### Naming Conventions als Datenbank-Ersatz
Dateibenennung kodiert Metadaten:
- `api-auth-guide_draft.md`
- `2026-03-launch-week.md`
- `demo_v2.md`

Ermoeglicht AI-gesteuerte Dateiorganisation ohne Code.

### Theoretische Fundierung
Separation of Concerns (Software Engineering seit 1972).

---

## Lektion 3.2 — Customizing for Your Use Case

### Kernprinzip
> "the layers do not change. The labels do."

Drei identische Layer, angepasste Labels.

### Beispiel: Content Creator
- Workspaces: script-lab, production, distribution
- Je eigene CONTEXT.md mit Voice, Audience, Prozess, Standards
- Routing-Tabelle leitet Claude nach Task-Type

### Beispiel: Freelancer/Consultant
- Client-Workspaces pro Engagement (**verhindert Context-Bleed**)
- Shared templates Workspace
- Business-dev Workspace
- Je Client eigene CONTEXT.md

### Beispiel: Developer
- Workspaces: planning, src, docs, ops
- CONTEXT.md je mit Code-Patterns, Naming, Testing, Infrastructure
- Routing-Tabelle mit Skills-Spalte

### CLAUDE.md-Funktion
Top-Level-Router mit Routing-Tabelle: Task-Type → Ordner + Context-File.

### CONTEXT.md-Zweck
Workspace-spezifische Prozesse, Standards, Audience, Naming, Regeln.

### Implementation
Major Work Modes identifizieren → Context-Files unter einer Seite → Routing-Tabelle bauen → iterieren.

### Critical Principle
> "Context files function as 'living documents' requiring continuous refinement as projects change."

---

## Lektion 3.3 — Sieben Fehler in Folder-Architektur

### Fehler 1: CLAUDE.md zu lang
CLAUDE.md ist Routing-Dokument, kein Projekt-Briefing. Ueber 40-50 Zeilen → kontextuelles Material landet fehlplatziert, Token-Verschwendung, Routing-Signale verwaessern.

### Fehler 2: Routing-Tabelle fehlt
> "This forces Claude to guess which files to read, leading to inconsistent output."

Pflicht-Spalten: task type, location, required context file.

### Fehler 3: Zu viele Workspaces
6-8 Workspaces bei 2-3 echten Work-Modi → Architektur schwerer als Arbeit.
**Test:** *"Do I shift mental modes between these tasks?"* Nein → ein Workspace mit Subfolders.

### Fehler 4: Context-Files beschreiben Claude, nicht die Arbeit
30 Zeilen AI-Verhalten ("be creative, be concise") vs 2 Zeilen echtes Projekt.
> "Context about the work (audience, constraints, completed work, success criteria) changes output far more than personality instructions."

### Fehler 5: Context-Files nie aktualisieren
> "Claude continues working from outdated specifications, producing drift that appears as capability loss. Treating context as working notes—updated as work progresses—is the system's highest-leverage habit."

### Fehler 6: Flache Struktur mit einer Datei
50 Files in einem Ordner ohne Subfolders zwingen Claude, ganze Directory-Listing zu parsen.
**Faustregel:** Subfolders bei > 8-10 Files pro Ebene.

### Fehler 7: Komplettes System bauen bevor nutzen
Sechs voll-detaillierte Workspaces ohne einen einzigen Prompt = verschwendeter Aufwand.
**Erste Version in 15 Min:** 1 CLAUDE.md, 1-2 Workspaces, minimal CONTEXT.md. Inkrementell wachsen.

### Unifying Pattern
> "keep the system small, work-focused (not Claude-focused), and evolving."

Three-Layer-Modell funktioniert wenn jedes Element **nur seinen Job macht**.

---

## Quellen

- [Lektion 1.2](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=fdee3f73c53b46049078494c0cfb2e54)
- [Lektion 1.3](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=05230de8023d463f8d38fddc19152ae2)
- [Lektion 3.1](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=2b4a8ab7461c4f6d828e21c0eb196a6a)
- [Lektion 3.2](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=1285fe09df7943e79e5d71c68b8b3ccb)
- [Lektion 3.3](https://www.skool.com/quantum-quill-lyceum-1116/classroom/036893d9?md=7b1919bbe3af42aa859b6060e4e7513f)
