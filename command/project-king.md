Aktiviere den Skill `project-king` (liegt unter `~/.claude/skills/project-king/SKILL.md`)
und fuehre den Bootstrap-Interview-Prozess gemaess Meta-Architektur V4 durch.

Wenn der User nach dem Befehl noch Text mitgibt — z.B. `/project-king mein-projekt` oder
`/project-king bestehendes projekt` — nutze das als Hinweis:

- Sieht es aus wie ein Projekt-Name (kebab-case, einzelne Woerter)? → als Vorschlag fuer
  Phase 1 Frage 1 behandeln.
- Enthaelt es "bestehend" / "existing" / "migration" / "vorhandenes"? → Phase 0 direkt auf
  Migrations-Modus stellen.
- Enthaelt es "neu" / "new" / "fresh"? → Phase 0 direkt auf Neu-Modus stellen.
- Sonst → Phase 0 normal starten.

Der Skill-Inhalt (SKILL.md) ist die verbindliche Quelle — folge dem Workflow dort,
dieser Command ist nur Trigger + Vor-Ausfuellung.
