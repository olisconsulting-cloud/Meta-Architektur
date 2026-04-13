# Meta-Architektur fuer Claude Code

Jedes neue Projekt startet in 15 Minuten sauber strukturiert. Ein Skill, ein Template, gepruefte Prinzipien.

## Was ist das?

Eine erprobte Ordner- und Datei-Architektur fuer komplexe Claude-Code-Projekte. Drei-Datei-Trio pro Workspace (CLAUDE.md Router + CONTEXT.md Arbeit + REFERENCES.md Tiefe), Pflicht-Routing-Tabelle, ADR-Governance. Loest zwei konkrete Probleme: Accuracy-Drift bei akkumulierter CLAUDE.md-Kette ueber 200 Zeilen, und "Claude raet ohne Routing-Tabelle".

Basis ist die Skool-Quantum-Quill-Lyceum-Lehre, plus Konsolidierung aus praktischer Anwendung.

## Installation

```bash
git clone https://github.com/olisconsulting-cloud/Meta-Architektur.git
cd Meta-Architektur
bash install.sh
```

Der Installer kopiert den Skill nach `~/.claude/skills/project-king/` und den Slash-Command nach `~/.claude/commands/project-king.md`, und schreibt den Template-Pfad in die Skill-Config. Das Repo selbst bleibt liegen, wo du es klonst.

**Voraussetzungen:** Bash (unter Windows: Git Bash oder WSL), Claude Code installiert.

## Erste Nutzung

In Claude Code — drei Aktivierungs-Wege:

```text
/project-king                     # Slash-Command (schnellster Weg)
neues Projekt bootstrappen        # Keyword-Phrase
nutze den project-king Skill      # explizit
```

Der Skill fuehrt durch sechs Fragen (Name, Zone, Zweck, Task-Types, Audience, Erfolg), erzeugt den Workspace, validiert die Qualitaets-Gates. Nach zwei bis drei Minuten hast du ein vollstaendiges Trio plus `_meta.yml` plus `decisions/TEMPLATE.md`.

Wenn du die Meta-Architektur noch nicht kennst, antworte auf die zweite Frage in Phase 0 mit `erklaere` — dann fuehrt dich der Skill durch die Prinzipien mit einem Satz Kontext pro Frage, ohne Extra-Fragen.

## Konzept in einer Minute

**Drei Schichten:**

1. **Wissens-Zustaende** — jede Datei hat genau einen: Evergreen (gilt jetzt), Immutable (warum wurde es so), Ephemeral (was tue ich gerade). Kategorien-Fehler ist der haeufigste Workspace-Verfall.
2. **Drei-Datei-Trio** — CLAUDE.md (Router, auto-load, <50 Z.), CONTEXT.md (Arbeit, task-load, <100 Z.), REFERENCES.md (Tiefe, on-demand, unbegrenzt).
3. **Fuenf Zonen** — products/, capital/, clients/, knowledge/, ops/. Rein strukturell, keine Arbeits-Rolle.

**Warum es funktioniert:** CLAUDE.md laedt automatisch, aber bleibt schmal. CONTEXT.md hat volle Tiefe, aber nur wenn Task es braucht. REFERENCES.md ist beliebig tief und kostet nie Kontext. Accumulation loest sich strukturell, nicht per Disziplin.

## Mehr Tiefe

- [docs/plan-v4.md](docs/plan-v4.md) — Vollversion der Theorie
- [docs/decisions/](docs/decisions/) — fuenf fundamentale Entscheidungen (ADRs)
- [docs/glossary.md](docs/glossary.md) — Begriffs-Alignment
- [docs/skool-zitate.md](docs/skool-zitate.md) — Primaer-Quelle
- [example/example-workspace/](example/example-workspace/) — gebootstrapptes Beispiel zum Angucken ("blog-platform")

## Update

```bash
cd Meta-Architektur
git pull
bash install.sh
```

Installer ueberschreibt den Skill (fragt vorher). Template-Pfad wird neu gesetzt, falls Repo verschoben wurde.

## Troubleshooting

**"Template-Pfad nicht konfiguriert" im Skill:** `.config` fehlt. `install.sh` nochmal ausfuehren.

**install.sh findet Claude-Verzeichnis nicht:** `CLAUDE_HOME` als Environment-Variable setzen, falls dein Claude nicht in `~/.claude/` liegt.

**Skill triggert nicht:** Claude Code neu starten nach Install — Skill-Registry wird beim Start geladen.

## Lizenz

MIT (siehe [LICENSE](LICENSE)).
