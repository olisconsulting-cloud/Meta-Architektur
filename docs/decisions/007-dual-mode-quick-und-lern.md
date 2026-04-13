# ADR 007: Dual-Mode — Quick-Modus und Lern-Modus

Datum: 2026-04-13 | Status: accepted | Superseded by: —

## Kontext

Der Skill `project-bootstrap` hat heute 6 Fragen in Phase 1 (Name, Zone, Zweck, Task-Types, Audience, Erfolg). Das Interview ist effizient (~3 Min), erzeugt produktionsreife Workspaces und blockt Skool-Fehler #7 ("komplettes System bauen bevor nutzen") strukturell.

Das Repo ist public (`github.com/olisconsulting-cloud/Meta-Architektur`). Der Skill soll drei Zielgruppen dienen:
1. Oliver selbst und Kunden in der 1:1-Beratung (wiederkehrende Nutzung, hohes Vorwissen).
2. Schueler in seiner KI-Schulung (erste Nutzung, null Vorwissen).
3. Fremde aus der Community (heterogenes Vorwissen).

Problem: Erst-User bekommen einen Workspace, aber kein Verstaendnis der zugrundeliegenden Prinzipien. Sie wissen nach Bootstrap nicht, **warum** die Drei-Datei-Architektur so aussieht, **warum** kebab-case, **warum** Routing-Tabelle. Langfristig: Living-Document-Disziplin wird ignoriert, Workspaces verfallen still.

Varianten (siehe `docs/research/skill-vs-tutorial-design.md`):
- A: Status quo (nur Quick-Modus).
- B: Lern-Modus als einziger Modus (Skill wird Schulungs-Werkzeug).
- C: Hybrid mit Modus-Weiche in Phase 0.

## Entscheidung

**Variante C (Hybrid).** Phase 0 bekommt eine zweite Frage: *"Kennst du die Meta-Architektur schon, oder soll ich kurz erklaeren was wir tun und warum?"*

- Antwort `kenne` → Quick-Modus (heutiger Flow unveraendert).
- Antwort `erklaere` → Lern-Modus (vor jeder der 6 Fragen ein 1-Satz-Lernhaeppchen + ein Pointer auf bestehende Doku).

Gleiche 6 Fragen in beiden Modi. Output ist identisch. Nur Rahmung unterscheidet.

## Begruendung

- Variante A loest das Erst-User-Problem nicht.
- Variante B laedt Schulungs-Overhead auf wiederkehrende Nutzer ab (Oliver zahlt bei jeder Nutzung) und blaeht SKILL.md kritisch auf. Skool-Fehler #7 waere verletzt.
- Variante C erreicht beide Zielgruppen mit minimaler Kopplung. Quick-Modus bleibt der Default-Pfad fuer Wiederkehr.
- Lernhaeppchen sind **Pointer** auf existierende Files (`plan-v4.md`, `skool-zitate.md`, `decisions/*`, `bootstrap-questions.md`) — keine Doppel-Pflege, kein Drift-Risiko.

## Konsequenz

- SKILL.md Phase 0 bekommt zweite Frage + `learn_mode`-Variable.
- Phase 1 bekommt pro Frage einen Lernhaeppchen-Block, der **nur bei `learn_mode=true`** ausgegeben wird.
- Harte Disziplin: max. **1 Satz Essenz + 1 Pointer** pro Frage. Keine Essays, keine Quiz-Elemente, keine "bist du sicher?"-Checks.
- Keine zusaetzlichen Fragen — Anzahl bleibt bei 6.
- SKILL.md waechst von ~265 auf ~330-340 Z. — bleibt im akzeptablen Skill-Rahmen (Trigger-Description unberuehrt).
- Pointer zeigen auf bestehende Files; wenn diese Files sich aendern, bleiben Pointer gueltig (keine Inhalts-Duplikate).
- Reversibilitaet: Wenn Lern-Modus ungenutzt bleibt, kann die Weiche in einer ADR 00N+ zurueckgebaut werden.

## Wartungs-Trigger

- Wenn ein Lernhaeppchen in der Praxis laenger als 1 Satz wird: STOPP, Content gehoert in Plan V4 oder ADR, nicht in Skill.
- Wenn ein Pointer auf einen nicht-existenten oder umbenannten Pfad zeigt: Skill-Fehler, sofort fixen (Pointer-Drift-Test: `grep -o 'docs/[^ ]*' SKILL.md` + manuelle Pruefung).
