# ADR 001: CLAUDE.md als Router, nicht als Context-Briefing

Datum: 2026-04-12 | Status: accepted | Superseded by: —

## Kontext

Bei der Ausarbeitung der Meta-Architektur kollidieren zwei Lehren:

- **File-Engineering-Lehre:** CLAUDE.md ist evergreen Kontext, Sweet-Spot 60-100 Zeilen, Gesamt-Akkumulation aller CLAUDE.md < 200 Zeilen entscheidet Accuracy-Zone.
- **Skool Quantum Quill Lyceum:** CLAUDE.md ist **Router** (40-50 Z., funktional-schmal), semantische Tiefe lebt in CONTEXT.md die nur task-basiert geladen wird.

Die Rollen der CLAUDE.md sind inkompatibel — man kann nicht gleichzeitig Router und Kontext-reiches Briefing sein.

## Entscheidung

**Skool-Linie hat Vorrang.** Konkret:
- CLAUDE.md = Router mit Pflicht-Routing-Tabelle (Task-Type | Location | Context-File)
- CONTEXT.md = "die Arbeit selbst" (Zweck, Audience, Erfolg, zu vermeidende Fehler)
- REFERENCES.md = Tiefenwissen, on-demand

## Begruendung

- Akkumulations-Problem loest sich **automatisch**: CONTEXT.md akkumuliert nicht, wird nur bei Task-Bedarf geladen
- CLAUDE.md bleibt unter 50 Zeilen ohne semantische Verluste
- Generische Anti-Patterns (Persona, Tutorials, Prosa, Changelog) bleiben gueltig — sie sind orthogonal zur Router-Rolle
- Bei Konflikten in Folge-Entscheidungen: Skool-Linie ist Default-Richter

## Konsequenz

- Jede CLAUDE.md braucht Routing-Tabelle
- Kein Persona-Text in CLAUDE.md (gehoert global oder in CONTEXT.md)
- Context-Tiefe wandert systematisch nach CONTEXT.md
