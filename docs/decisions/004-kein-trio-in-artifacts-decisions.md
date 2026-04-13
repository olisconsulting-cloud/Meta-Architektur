# ADR 004: Kein Trio in artifacts/, decisions/ — nur in Rooms

Datum: 2026-04-12 | Status: accepted | Superseded by: —

## Kontext

Brauchen `artifacts/`, `decisions/`, `rooms/` jeweils eigene CONTEXT.md (Drei-Datei-Architektur)?

Die Frage ist wichtig, weil ADR 003 ("Drei-Datei-Architektur Pflicht pro Workspace") in naiver Lesart bedeuten koennte: jeder Unterordner braucht Trio. Das waere CLAUDE.md-Inflation (Anti-Pattern #6).

## Entscheidung

**Trio nur pro Workspace, nicht pro Subfolder.**

Ein Workspace ist definiert als: eigener Arbeitsraum mit eigener Routing-Tabelle und eigenem mentalen Modus. Konsequenzen:

- **artifacts/** bekommt KEIN Trio. Es ist Ablage, kein Arbeitsraum. Zugriff erfolgt via Routing-Tabelle des Parent-Workspace.
- **decisions/** bekommt KEIN Trio. ADRs haben eigenes Format (Kontext/Entscheidung/Konsequenz) und brauchen keinen eigenen Kontext.
- **rooms/** selbst bekommt KEIN Trio. Es ist Meta-Container.
- **Ein einzelner Room** (z.B. `rooms/research/`) bekommt ein Trio, sobald er angelegt wird — weil er ein echter Arbeits-Modus ist.

## Begruendung

Skool-Test: *"Shifte ich mental mode wenn ich in diesem Ordner arbeite?"*
- artifacts/: Nein — ich lege nur Ergebnisse ab
- decisions/: Nein — ich schreibe nur ADRs nach Template
- rooms/ (Container): Nein — ich waehle nur welchen Room
- rooms/research/: Ja — research-Modus anders als synthesis-Modus

Das 15-Min-Bootstrap-Prinzip (Skool-Fehler #7): nicht vorab strukturieren, nur anlegen wenn echt gebraucht.

## Konsequenz

- Workspace-Struktur bleibt schlank — kein Trio-Zwang in jedem Unterordner
- Beim Anlegen eines ersten Room: Template aus `template/project-skeleton/` kopieren
- Routing-Tabelle des Parent-Workspace muss dann Room-Eintraege bekommen
- **Anti-Pattern zu vermeiden:** "CLAUDE.md in jedem Subdir" — genau hier liegt die Gefahr bei naiver ADR-003-Lesart
