# Glossary — Meta-Architektur

Begriffs-Alignment. On-demand lesen bei Begriffsstreit oder Unsicherheit.

---

## Struktur-Ebenen

### Workspace
Ein Ordner mit eigener Drei-Datei-Architektur (CLAUDE+CONTEXT+REFERENCES). Kann Top-Level sein oder verschachtelt (ein Projekt). Definition: **hat eigene Routing-Tabelle**.

### Zone
Eine der fuenf **ontologischen Kategorien** auf Workspace-Root-Ebene: products/, capital/, clients/, knowledge/, ops/. Rein strukturell, keine Arbeits-Rolle. Siehe ADR 002.

### Projekt
Ein konkretes Vorhaben innerhalb einer Zone. Beispiel: `products/blog-platform/` ist ein Projekt in Zone products/. Hat eigenes Trio.

### Room
**Mentaler Modus** innerhalb eines Projekts (Skool-Konzept). Nicht Ordner-Typ. Ein Projekt hat Rooms, wenn man **echt den Denkmodus wechselt** zwischen Tasks (z.B. development vs deployment vs demo). Test: *"Shifte ich mental mode?"* Wenn nein -> kein Room, Subfolder reicht.

---

## Die drei Kern-Dateien

### CLAUDE.md
**Evergreen, auto-load beim Workspace-Entry.** Router mit Pflicht-Routing-Tabelle. Funktional-schmal (<50 Zeilen). Enthaelt keine semantische Tiefe — die liegt in CONTEXT.md. Skool-Rolle: *"tells the AI: for this task, read these files, skip those files."*

### CONTEXT.md
**Evergreen, task-load via Routing-Tabelle.** Beschreibt **die Arbeit**, nicht Claude. Drei Pflicht-Abschnitte: Zweck, Audience, Erfolgskriterien. Plus: zu vermeidende Fehler, aktueller Stand, naechster Schritt. Living Document — waehrend Arbeit aktualisieren.

### REFERENCES.md
**Evergreen tief, on-demand.** Externe und interne Quellen. Wird nie automatisch geladen. Muss Lade-Anweisung enthalten ("Diese Datei nur lesen wenn..."). Darf beliebig tief sein — keine Kontext-Kosten.

---

## CONTEXT.md vs context.md

**Zwei verschiedene Dinge. Schreibweise unterscheidet.**

- **CONTEXT.md** (Grossbuchstaben) = Evergreen, Workspace-Level, Drei-Datei-Architektur
- **context.md** (Kleinbuchstaben) = Ephemeral, Phase-Level, lebt in Phase-Ordnern, stirbt nach Task-Ende

Kategorien-Fehler: ephemere Task-Notes in CONTEXT.md schreiben -> Evergreen vergiftet.

---

## Die drei Wissens-Zustaende

### Evergreen
*"Was gilt jetzt?"* — kurz halten, **waehrend** Arbeit aktualisieren. Beispiele: CLAUDE.md, CONTEXT.md, GLOSSARY. Regel: Wenn nicht mehr aktuell -> sofort fixen, nicht monatlich.

### Immutable
*"Warum wurde es so?"* — darf wachsen, wird nur on-demand gelesen. Beispiele: ADRs, chronicle. Regel: nie loeschen, nie umschreiben. Wenn obsolet -> neue ADR die alte supersedes.

### Ephemeral
*"Was tue ich gerade?"* — muss sterben nach Task-Ende. Beispiele: context.md, Task-Notes. Regel: wenn es nicht stirbt, vergiftet es Evergreen.

---

## capital/-Unterkategorien

### Blueprint
**Architektur-Muster.** Test: *"Muss ich es verstehen um es zu nutzen?"* -> ja. Beispiel: Voice-Agent-Architektur, Auth-Flow, Queue-Pattern.

### Stack
**Konfigurierte Werkzeugkette.** Test: *"Kann ich es einfach klonen?"* -> ja. Beispiel: Next+Tailwind+shadcn-Setup, getestete Prompts.

### Lib
**Geteilter Code.** Monorepo-Pattern. Beispiel: shared TypeScript-Types, Utility-Funktionen.

---

## Governance

### ADR (Architecture Decision Record)
Immutable Dokument pro Entscheidung. 3-Zeilen-Minimum: Kontext / Entscheidung / Konsequenz. Trigger: nur schreiben wenn Entscheidung **> 1h Refaktor-Kosten** bei Reversal haette. Datei: `decisions/NNN-titel.md`.

### Routing-Tabelle
Pflicht-Element in jeder CLAUDE.md (Workspace- oder Zonen-Ebene). Mindestens 3 Spalten: Task-Type | Location | Context File. Optional Skills-Spalte. **Ohne Routing-Tabelle raet Claude** (Skool-Fehler #2).

### Living Document
Prinzip: CONTEXT.md waehrend der Arbeit aktualisieren, nicht spaeter. Skool-Zitat: *"the system's highest-leverage habit."*

---

## Ordner-Konventionen

### _lab/
Unterzone in `products/_lab/` fuer Experimente und Prototypen. Underscore-Prefix signalisiert: nicht Produkt, sondern Proto-Produkt. **30-Tage-Halbwertszeit-Regel** — was 30 Tage nicht beruehrt wurde -> archive oder delete. Erfolgreiche Experimente wandern durch Umbenennen nach `products/<slug>/`. Siehe ADR 002.

### _meta.yml
Stumme Telemetrie pro Projekt. Keys: status, owner, created, last-touched, parent-zone, role. Wird von Reaping-Scripts konsumiert (monatlich).

### variants/
Parallele Varianten eines Ergebnisses. Beispiel: `clients/customer-x/variants/v1-classic/`, `v2-modern/`. Nicht `projekt-v2/`, nicht `projekt-neu/` (Schroedinger-Ordner = Anti-Pattern).

---

## Aktualisierung

Dieses Glossary waechst aus Reibung. Wenn ein Begriff in einer Diskussion mehrdeutig wird -> Eintrag hier klaeren. Nicht vorab-perfektionieren.
