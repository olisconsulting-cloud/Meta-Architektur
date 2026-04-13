# ADR 003: Drei-Datei-Architektur als Pflicht pro Workspace

Datum: 2026-04-12 | Status: accepted | Superseded by: —

## Kontext

Skool lehrt die Drei-Datei-Architektur (CLAUDE + CONTEXT + REFERENCES) als kanonische Einheit pro Workspace. Frage: Ist das Pflicht pro Workspace oder optional?

Alternativen:
- Nur CLAUDE.md, Rest optional
- Ganzes Trio immer
- Abhaengig von Scope-Groesse

## Entscheidung

**Pflicht pro Workspace-Ebene** (Workspace-Root, Projekt-Root, Room-Root falls Rooms genutzt werden).

Subfolders unterhalb eines Workspaces brauchen das Trio **nicht** — sie erben den Kontext vom Workspace darueber.

## Begruendung

- Drei-Stufen-Lade-Mechanismus funktioniert nur wenn alle drei Dateien existieren (auch initial leer)
- CLAUDE.md ohne CONTEXT.md bedeutet: Routing-Tabelle verweist auf nicht-existente Datei -> Rate-Fehler
- Leere REFERENCES.md ist billiger als fehlende REFERENCES.md (keine Sucherei bei Bedarf)
- Skool-Prinzip "15-Min-Bootstrap": minimale Dreiteilung, Wachstum durch Reibung — nicht vorab-perfektioniert, aber **strukturell vollstaendig**

## Konsequenz

- Jeder neue Workspace/Room/Projekt beginnt mit dem Trio (auch wenn Dateien initial kurz sind)
- Template-Bootstrap enthaelt das Trio als Vorlage
- Rooms brauchen das Trio **nur wenn sie echte Unique-Context-Regeln haben** — sonst reicht Subfolder
- CLAUDE.md-Inflation (in jedem Subdir) wird explizit vermieden: Trio pro Workspace, nicht pro Ordner
- Test bei Anlage eines neuen Scopes: "Brauche ich hier einen **eigenen Arbeitsraum** mit Routing-Tabelle?" Wenn ja -> Trio. Wenn nein -> Subfolder reicht.
