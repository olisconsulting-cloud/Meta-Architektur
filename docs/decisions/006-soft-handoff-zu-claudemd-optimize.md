# ADR 006: Soft Handoff zu `/claudemd-optimize` in Phase 5

Datum: 2026-04-13 | Status: accepted | Superseded by: —

> **Namens-Hinweis:** Der hier als `project-bootstrap` referenzierte Skill
> heisst seit Commit `7d600ce` (2026-04-13) `project-king`. Inhalt unveraendert.

## Kontext

Der Skill `project-bootstrap` erzeugt neue Workspaces nach Meta-Architektur V4. Parallel existiert der Slash-Command `/claudemd-optimize` (global in `~/.claude/commands/`), der CLAUDE.md-Files gegen 8 Prinzipien reviewt (Accuracy-Zonen, Redundanz, Sprach-Konsistenz, Gap-Check) und priorisierte Verbesserungs-Vorschlaege liefert — ohne Auto-Fix.

Scope-Ueberlappung zwischen Phase-4-Quality-Gates (syntaktisch: Zeilen, Platzhalter, Routing-Tabelle) und claudemd-optimize (semantisch: Prinzipien-Check) ist minimal. Die beiden sind komplementaer.

Problem: User, die durch den Skill bootstrappen, kennen den Pruefer oft nicht. Gebootstrappte Workspaces haben damit zwar stimmige Syntax, aber moegliche Prinzipien-Luecken bleiben unerkannt.

Alternative Varianten (siehe `docs/research/claudemd-optimize-integration.md`):
1. Nichts tun.
2. Soft Handoff (nur Hinweis in Phase 5).
3. Harte Integration (Phase 4 dupliziert Prinzipien-Checks).
4. Phase 4 ruft Command automatisch auf.

## Entscheidung

**Variante 2 (Soft Handoff).** Phase 5 des Skills bekommt einen 5. Punkt mit optionalem Hinweis auf `/claudemd-optimize`. Kein Auto-Aufruf, keine Pflicht, keine Dependency.

## Begruendung

- Variante 1 (Status quo) laesst User-Bildung ungeloest — Pruefer bleibt unsichtbar.
- Variante 3 (harte Integration) duplizierte Prinzipien-Logik zwischen Skill und Command, schafft Sync-Last und blaeht SKILL.md auf (Selbst-Verletzung von Prinzip 1).
- Variante 4 (automatischer Aufruf) macht den Skill abhaengig von einem global gepflegten Command, der in anderen Umgebungen fehlen kann → Skill wird brittle, Portabilitaet leidet.
- Variante 2 kostet ~5 Zeilen SKILL.md, hat null Dependencies, ist trivial reversibel, loest das User-Bildungs-Problem zuverlaessig.

## Konsequenz

- SKILL.md Phase 5 waechst um ~5 Zeilen. Formulierung betont "optional", "nicht Pflicht", "nach Anpassungen" — kein Banner-Rauschen.
- Keine harte Dependency zu `/claudemd-optimize` — wer den Command nicht installiert hat, kann den Hinweis ignorieren, Bootstrap bleibt erfolgreich.
- Bei kuenftigen Anpassungen am Command (z.B. Trio-Support): keine Aenderung am Skill noetig, solange Befehlsname stabil bleibt.
- Reversibilitaet: 5 Zeilen raus, Zustand wie heute.
