# Best Practices 2025/2026 — Externe Validierung der Meta-Architektur

Datum: 2026-04-13 | Status: Research-Befund, keine Umsetzung entschieden | Research via Perplexity MCP (`perplexity_ask`, Sonar Pro, `search_recency_filter=month`)

## Frage

Ist die Meta-Architektur (Drei-Datei-Trio CLAUDE+CONTEXT+REFERENCES, 5 Zonen, ADR-Governance) ein optimaler Meta-Build fuer AI-assisted Development 2025/2026 — oder haben wir externe Best Practices uebersehen?

## Methodik

Drei Perplexity-Web-Recherchen mit `search_recency_filter: month` + `search_context_size: high`:
1. Offizielle Guidance zu CLAUDE.md / AGENTS.md / llms.txt / Skills / Hooks / Subagents
2. Large-OSS-Workspace-Konventionen 2025/2026
3. Failure-Modes von Multi-File-Context-Architekturen + neue File-Engineering-Techniken

Ergebnisse sortiert nach **trifft zu** (validiert Skool-Linie) / **trifft nicht zu** (wir sind davon nicht betroffen) / **sollten wir adressieren** (echter Gap).

---

## 1. Kern-Befunde aus der Recherche

### 1.1 AGENTS.md als Cross-Tool-Standard (relevant)

- **Spec:** OpenAI hat AGENTS.md an die Agentic AI Foundation uebertragen (Dezember 2025). Zweck: ein root-level Markdown, den Codex CLI, Cursor (als Fallback), Claude Code, Aider und andere Agents lesen. ([augmentcode.com/guides/how-to-build-agents-md](https://www.augmentcode.com/guides/how-to-build-agents-md))
- **Struktur (empfohlen):** Folder-Structure-Mapping, Naming-Conventions, Validation/Run-Commands (lint, test), Anti-Patterns.
- **Hierarchisch:** root `AGENTS.md` wird von Subdir-Versionen ueberschrieben (z.B. `services/api/AGENTS.md`). ([maximilianocontieri.com/ai-coding-tip-014](https://maximilianocontieri.com/ai-coding-tip-014-use-nested-agents-md-files))
- **Anthropic-Stance:** Claude Code liest AGENTS.md als Fallback, bevorzugt aber CLAUDE.md. Empfohlen: CLAUDE.md **und** AGENTS.md parallel, Dopplung vermeiden (`deployhq.com/blog/ai-coding-config-files-guide`).

### 1.2 Dokumentiertes Sweet-Spot fuer Instruction-Files

- **Zahlen aus ETH-Zuerich-Studie (AGENTbench-Replik):** Human-curated Instruction-File < 200 Zeilen ergibt ~4% Task-Success-Gewinn. LLM-generierte Instructions schaden (-3% Success, +20% Token-Kosten). ([augmentcode.com](https://www.augmentcode.com/guides/how-to-build-agents-md))
- **Claude-Code-Praxis:** ~150 Instruction-Slots nach System-Prompt als Obergrenze; frontier LLMs handhaben ~150-200 Instructions. ([deployhq.com](https://www.deployhq.com/blog/ai-coding-config-files-guide))
- **Benchmark:** File-based Context mit Structured Memory boostet Claude Code auf SWE-bench um ~13%. ([taskade.com/blog/claude-code-alternatives](https://www.taskade.com/blog/claude-code-alternatives))
- **Context-Engineering-Paper:** Strukturierte Package-Splits mit "Authority"-Files senken Iterationen 3.8 → 2.0 und heben First-Pass-Success 32% → 55%. Zwei-File-Ansatz (Authority + Data) schlaegt Vier-File ohne Authority.

### 1.3 Failure-Modes von Multi-File-Architekturen

- **Drift:** Wenn nur eine Datei upgedatet wird, veralten die anderen → AI-Confusion. ([augmentcode.com/guides/session-end-spec-update-ai-agents](https://www.augmentcode.com/guides/session-end-spec-update-ai-agents))
- **Agent-Sprawl:** Ueberlappende/konfligierende Instructions ueber viele Files hinweg.
- **Irrelevanz-Crowd-out:** Wenn Tools nicht richtig filtern, verdraengen irrelevante Regeln kritische Instructions.
- **Context-Rot:** In wachsenden Konversationen favorisiert Sub-Agent-Isolation gegen flache Files. ([mindstudio.ai/blog/context-rot-ai-coding-agents-sub-agents-fix](https://www.mindstudio.ai/blog/context-rot-ai-coding-agents-sub-agents-fix/))
- **Static-File-Staleness:** CLAUDE.md veraltet schnell ohne Session-End-Annotation.

### 1.4 Emerging Techniques 2025/2026

- **Nested AGENTS.md / Auto-Load by Dir:** Closest-File-to-Task wins.
- **Scoped Rules (Always On / Auto / Manual / Model-decide):** Cursor `.cursor/rules/*.mdc` hat vier Lade-Modi.
- **Operator Authority Files:** Versionierte Constraints in jedem Package, messbar besser als Exemplars allein.
- **@-Imports mit 5-Hop-Rekursion:** Approval-gated, vermeidet Context-Pollution.
- **MCP Servers als Context-Source:** Externe Resources werden als @-Reference eingebunden.
- **Sub-Agents gegen Context-Rot:** Isolierte Sub-Tasks statt Hauptkontext aufblaehen.
- **Multi-Model-Routing:** Cursor orchestriert Claude/GPT je Task.
- **Anthropic Managed Agents (Beta April 2026):** YAML-basierte Agent-Definitionen, nutzt **kein** CLAUDE.md. ([anthropic.com/engineering/managed-agents](https://www.anthropic.com/engineering/managed-agents))

---

## 2. Bewertung gegen Meta-Architektur V4

### 2.1 Trifft zu — validiert die Skool-Linie

| Befund | Was validiert wird |
|--------|--------------------|
| Sweet-Spot < 200 Zeilen, ~150 Slots Obergrenze | Unsere CLAUDE.md < 50 Z. + Pflicht-Routing-Tabelle trifft das mit Headroom |
| "Authority-Files" schlagen Exemplars | Plan V4 + ADRs sind genau das — immutable Authority |
| Structured File-based Context +13% SWE-bench | Drei-Datei-Trio ist strukturierter Memory-Split |
| Nested-File-Pattern (root + subdir ueberschreibt) | ADR 004 (Trio nur pro Workspace, nicht pro Subfolder) folgt diesem Prinzip |
| LLM-generated Instructions schaden (-3%) | Unsere handgepflegten ADRs sind Human-curated — das ist der gute Pfad |
| Cursor Scoped Rules mit Lade-Modi (Always On / Auto / Manual) | Unsere drei Lade-Modi (auto/task/on-demand) sind exakte Parallele |

**Zentrale Bestaetigung:** Die drei Lade-Stufen (CLAUDE.md auto-load, CONTEXT.md task-load, REFERENCES.md on-demand) sind in der Industrie unabhaengig als Best Practice konvergiert. Skool hat das aus Pedagogik abgeleitet, Cursor/Anthropic aus Benchmarks. Konvergenz = starkes Signal.

### 2.2 Trifft nicht zu — wir sind davon nicht betroffen

| Befund | Warum nicht auf uns anwendbar |
|--------|-------------------------------|
| Agent-Sprawl durch ueberlappende Files | Unsere ADR 003 + 004 verhindern CLAUDE.md-Inflation strukturell |
| Drift bei Teil-Updates | Living-Document-Disziplin (Plan V4) adressiert das — aber nur als Regel, nicht strukturell erzwungen (siehe 2.3) |
| Context-Rot in langen Konversationen | Meta-Architektur operiert auf Workspace-Ebene, nicht Session-Ebene — Rot ist ein Session-Problem |
| Managed Agents ohne CLAUDE.md | Managed Agents sind ein anderes Produkt (Server-side YAML-Agents), Claude Code bleibt File-basiert |

### 2.3 Sollten wir adressieren — echte Gaps

**Gap A: AGENTS.md-Kompatibilitaet fehlt**
- Problem: Unser Template erzeugt nur CLAUDE.md. Projekte, die mit Codex CLI, Cursor, Aider gleichzeitig genutzt werden, brauchen AGENTS.md zusaetzlich.
- Impact: Niedrig fuer Oliver persoenlich (Claude-only Workflow), aber relevant fuer Kundenprojekte mit gemischtem Tooling.
- Quelle: [augmentcode.com](https://www.augmentcode.com/guides/how-to-build-agents-md), [deployhq.com](https://www.deployhq.com/blog/ai-coding-config-files-guide)
- Moegliche Reaktion:
  - (a) Neue ADR 006: "AGENTS.md als optionaler Co-Router beim Bootstrap anbieten — nicht Pflicht."
  - (b) Nichts tun, Claude-Code-First bleibt die These.
  - (c) Template-Erweiterung: AGENTS.md als generierbare Variante ("neues Projekt bootstrappen --cross-agent").

**Gap B: Session-End-Spec-Update-Ritual fehlt**
- Problem: Unsere Living-Document-Disziplin ist eine Regel ("waehrend Arbeit aktualisieren"), aber kein Prozess. Augmentcode-Recherche zeigt: Session-End-Annotation verhindert Staleness messbar besser als Mid-Work-Updates.
- Quelle: [augmentcode.com/guides/session-end-spec-update-ai-agents](https://www.augmentcode.com/guides/session-end-spec-update-ai-agents)
- Moegliche Reaktion:
  - (a) Kein Skill-Change noetig — Olivers globale CLAUDE.md hat bereits ein Session-Ende-Protokoll. Projekt-Bootstrap koennte dieses Protokoll als Reminder in CONTEXT.md oder in Phase 5 des Skills referenzieren.
  - (b) Neue ADR: "Session-End-Annotation als Pflicht-Ritual im Bootstrap-Abschluss."

**Gap C: Scoped-Rules-Konzept nicht explizit**
- Problem: Cursor und Codex CLI haben explizite Lade-Modi (Always On / Auto / Manual / Model-decide) fuer Rules. Unser Trio hat aequivalente Modi (auto/task/on-demand), aber der User muss das aus dem Plan V4 ableiten — es steht nicht auf der Datei selbst.
- Moegliche Reaktion:
  - (a) Template-Erweiterung: Frontmatter in CLAUDE.md/CONTEXT.md/REFERENCES.md mit `load-mode: auto|task|on-demand` — macht Skool-Konvention maschinenlesbar.
  - (b) Nichts tun, die Konvention ergibt sich aus dem Dateinamen.
  - (c) Reicht als Hinweis in einer optionalen ADR 006 + README-Update.

**Gap D: Operator Authority Files nicht als eigenes Konzept benannt**
- Problem: Die Forschung ([arxiv.org/html/2604.04258v1](https://arxiv.org/html/2604.04258v1)) zeigt: "Authority-Files" (versionierte, immutable Constraints) verbessern First-Pass-Success messbar. Wir haben ADRs, aber keine explizite Brücke zum Konzept.
- Moegliche Reaktion: Keine Aenderung noetig — ADRs **sind** Authority Files in unserer Sprache. Ggf. Glossary-Eintrag "ADR = Authority File im Context-Engineering-Jargon" fuer externe Verstaendlichkeit.

**Gap E: MCP Servers als REFERENCES.md-Quellen nicht erwaehnt**
- Problem: 2026 wird zunehmend MCP statt reiner File-Referenzen genutzt. Unsere REFERENCES.md hat "Interne Quellen / Externe Quellen" — keine MCP-Kategorie.
- Moegliche Reaktion:
  - (a) Template-Erweiterung REFERENCES.md: dritte Sektion "MCP-Quellen" (mit Lade-Trigger).
  - (b) Als Hinweis in Glossary + Plan V4.

---

## 3. Ergebnis-Zusammenfassung

**Die Drei-Datei-Architektur ist durch externe Evidenz 2025/2026 robust validiert.** Sweet-Spot-Zeilen, Authority-File-Konzept, Lade-Modi, Nested-Files-Prinzip — alle laufen in die gleiche Richtung wie Skool. Die These "CLAUDE.md als schmaler Router" ist gegen den April-2026-Stand der Industrie konvergent.

**Fuenf Gaps sind dokumentiert**, davon sind zwei niedrig-prioritaer (D, E — kosmetisch), einer mittel (B — Session-End-Ritual) und zwei potenziell hoch (A — AGENTS.md, C — Scoped-Rules-Frontmatter).

**Keine Widersprueche zu ADRs 001-005** — alle Gaps sind **additiv**, nicht korrektiv. Wenn Oliver etwas adressieren will, braucht es eine neue ADR 006+, kein Superseding.

---

## 4. Empfehlung fuer Oliver

Nach Vorschlag-pruefen-Memory: **drei Varianten zur Wahl**, nicht eine Empfehlung.

### Variante A — Nichts aendern, Doku nachziehen
- **Staerken:** Minimal-invasiv, keine ADR-Flut, Skill-Stabilitaet.
- **Schwaechen:** AGENTS.md-Kompatibilitaet bleibt Manual-Work fuer Kunden mit Cross-Tooling.
- **Schatten:** Oliver koennte in 6 Monaten feststellen, dass 40% der Kunden AGENTS.md brauchen — dann muss nachgesteuert werden unter Zeitdruck.

### Variante B — Gap A (AGENTS.md) + Gap B (Session-End) adressieren
- **Staerken:** Loest die beiden materiellen Gaps ohne Ueberkomplexitaet. Zwei neue ADRs 006-007, Skill bekommt optionalen Flag und Phase-5-Reminder.
- **Schwaechen:** Skill wird um ~20% laenger, Doku-Last steigt.
- **Schatten:** Moeglicher Konflikt mit "Skill-Bloat" — die aktuell 265-Zeilen SKILL.md nimmt weiter zu. Rest-Risiko: Skill triggert nicht mehr zuverlaessig.

### Variante C — Gap A + B + C + E voll adressieren (Breitwand-Refit)
- **Staerken:** Meta-Architektur wird zu einem 2026-state-of-the-art-Set. Wertsteigerung fuer eventuelle Publikation / Oeffentlichkeit.
- **Schwaechen:** 4 neue ADRs, Template-Aenderung, Skill-Erweiterung. Hoher Aufwand, bricht das 15-Min-Bootstrap-Versprechen (Skool-Anti-Pattern #7).
- **Schatten:** Vorab-Perfektion. Genau der Fehler, den Skool-Fehler #7 warnt. Oliver hat noch keinen dokumentierten Schmerz zu Gaps C + E — sie sind theoretisch, nicht empirisch.

**Ehrliche Inversion:** Ist die Recherche ueberhaupt notwendig? Wenn Olivers aktueller Workflow gut laeuft und die Kundenprojekte Claude-only sind — dann ist **Variante A** objektiv korrekt. Die Recherche hat **keine akute Schwaeche** gefunden, nur theoretische Luecken gegen hypothetische Zukunftsszenarien.

**Meine Tendenz (eine Meinung, nicht die Entscheidung):** Variante A als Default, Variante B sobald ein Kunde tatsaechlich Cross-Agent-Tooling mitbringt. Reibung entscheiden lassen, nicht Vorab-Perfektion.

---

## 5. Quellen (vollstaendig)

### Primaer (Empfehlungen, Specs, Official)
- [Augment Code — How to build AGENTS.md](https://www.augmentcode.com/guides/how-to-build-agents-md)
- [DeployHQ — AI Coding Config Files Guide](https://www.deployhq.com/blog/ai-coding-config-files-guide)
- [Anthropic — Long Running Claude](https://www.anthropic.com/research/long-running-Claude)
- [Anthropic — Managed Agents](https://www.anthropic.com/engineering/managed-agents)
- [Maximiliano Contieri — Nested AGENTS.md Files](https://maximilianocontieri.com/ai-coding-tip-014-use-nested-agents-md-files)

### Benchmarks & Forschung
- [Context Engineering Study (arxiv 2604.04258)](https://arxiv.org/html/2604.04258v1)
- [Taskade — Claude Code Alternatives / SWE-bench-Zahlen](https://www.taskade.com/blog/claude-code-alternatives)

### Praxis-Writeups & Kritiken
- [Augment Code — Session-End Spec Update](https://www.augmentcode.com/guides/session-end-spec-update-ai-agents)
- [MindStudio — Context Rot & Sub-Agents Fix](https://www.mindstudio.ai/blog/context-rot-ai-coding-agents-sub-agents-fix/)
- [Blake Crosley — Claude Code Systems](https://blakecrosley.com/guides/claude-code)
- [Code with Mukesh — Anatomy of .claude/](https://codewithmukesh.com/blog/anatomy-of-the-claude-folder/)
- [Pere Villega — Opinionated Claude Code Starter](https://perevillega.com/posts/2026-04-12-an-opinionated-starting-point-for-claude-code-users)
- [Towards AI — Top 1% Claude Code Playbook](https://pub.towardsai.net/becoming-a-top-1-claude-code-user-the-complete-playbook-no-one-else-is-sharing-96057be1468e)

### Community / Templates
- [Claude Code Templates (Abhishek Ray)](https://github.com/abhishekray07/claude-md-templates)
- [Rohit — Awesome Claude Code Toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit)
- [MindStudio — CLAUDE.md als permanent manual](https://www.mindstudio.ai/blog/what-is-claude-md-file-permanent-instruction-manual/)

---

**Transparenz zur Methode:** Ein erster `perplexity_research`-Call (Deep-Research-Model) hat wegen eines Knowledge-Cutoff-Arguments keine Live-Daten geliefert. Die hier zitierten Befunde stammen aus drei `perplexity_ask`-Calls (Sonar Pro mit `search_recency_filter=month`, high context), die aktuelle Web-Ergebnisse ausgewertet haben. Alle URLs sind direkt aus diesen Antworten — nicht aus LLM-Knowledge. Pruefe stichprobenartig, bevor du Entscheidungen triffst.
