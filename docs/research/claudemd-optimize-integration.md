# Integration von `/claudemd-optimize` mit `project-bootstrap`

Datum: 2026-04-13 | Status: Analyse, keine Umsetzung entschieden

> **Namens-Hinweis:** Der Skill wurde am 2026-04-13 zu `project-king` umbenannt.
> Dieses Research-Dokument nennt noch den alten Namen `project-bootstrap` als
> Zeitpunkt-Snapshot. Inhalt gilt unveraendert fuer `project-king`.

## Frage

Sollten `project-bootstrap` (legt neue Workspaces an) und `/claudemd-optimize` (reviewed bestehende CLAUDE.md) verbunden werden — und wenn ja, wie?

## Scope-Vergleich

### `project-bootstrap` Phase 4 Quality-Gates (heute)

Aus `SKILL.md` Zeilen 212-222:

- `wc -l CLAUDE.md` < 50 → Warnung
- `wc -l CONTEXT.md` < 100 → Warnung
- `grep "<" *.md` → Platzhalter muessen ersetzt sein
- `grep "YYYY-MM-DD" _meta.yml` → darf leer sein
- Routing-Tabelle hat mindestens 2 echte Zeilen

**Charakter:** Syntaktisch-strukturell. "Sind die Schluesselzahlen stimmig, sind Platzhalter ersetzt, existiert eine Tabelle."

### `/claudemd-optimize` (heute)

Aus `C:\Users\olisc\.claude\commands\claudemd-optimize.md`:

- Accuracy-Zonen-Analyse (Hierarchie-Summe mit Rules-Files)
- Section-by-Section-Bewertung gegen 8 Prinzipien
- Frontmatter-Analyse (`paths:`, `description:`)
- Redundanz-Check gegen `~/.claude/rules/*.md`
- Gap-Check (fehlen Bash-Befehle, Test-Runner, ADR-Pointer?)
- Sprach-Konsistenz-Check
- Scoring auf 4 Dimensionen + Top-10 priorisierte Verbesserungen
- Explizit **ohne Auto-Fix** — User entscheidet

**Charakter:** Semantisch-qualitativ. "Ist diese CLAUDE.md in der richtigen Accuracy-Zone, sind Inhalte in Prinzipien-Konflikt, gibt es Redundanzen mit globalen Rules?"

### Ueberlappung

| Check | Phase 4 | claudemd-optimize |
|-------|---------|-------------------|
| CLAUDE.md-Zeilenzahl | Hart-Check (<50) | Zonen-Analyse mit Hierarchie |
| Routing-Tabelle existiert | Ja (Mindestens 2 Zeilen) | Nein (nimmt Existenz an) |
| Platzhalter entfernt | Ja | Nein |
| Datum-Template-Stubs | Ja | Nein |
| Section-Qualitaet | Nein | Ja (8 Prinzipien) |
| Redundanz mit globalen Rules | Nein | Ja |
| Sprach-Konsistenz | Nein | Ja |
| Gap-Check (fehlende Inhalte) | Nein | Ja |

**Fazit:** Ueberlappung ist minimal. Phase 4 ist **struktureller Abnahme-Test**, claudemd-optimize ist **Optimierungs-Review**. Komplementaer, nicht redundant.

---

## Varianten

### Variante 1 — Getrennt lassen (Status quo)

**Idee:** Beide Werkzeuge bleiben unabhaengig. Keine Aenderung.

- **Staerken:**
  - Jedes Werkzeug macht seinen Job ohne Seiteneffekte.
  - Skill bleibt schlank (265 Z. SKILL.md), kein Coupling zu globalem Commands-Ordner.
  - claudemd-optimize bleibt Claude-Code-weit nutzbar (nicht nur nach Bootstrap).
- **Schwaechen:**
  - User muss wissen, dass er nach Bootstrap noch `/claudemd-optimize` laufen lassen koennte — steht nirgends als Hinweis.
  - Gefahr: "Workspace angelegt, Routing-Tabelle da, Platzhalter weg" → User glaubt Datei sei fertig, laesst aber Prinzipien-Verletzungen stehen.
- **Schatten:** Oliver koennte in 6 Monaten feststellen, dass gebootstrappte Workspaces systematisch die Accuracy-Zone "60-100 Zeilen" verpassen, weil CONTEXT.md beim Bootstrap weich gefuellt wurde — claudemd-optimize wuerde das sofort flaggen, aber niemand triggert es.

**Aufwand:** 0. Eleganz: hoch. Risiko: User-Bildung noetig.

### Variante 2 — Soft Handoff in Phase 5

**Idee:** Nach Phase 5 (Abschluss-Ritual) zeigt der Skill einen zusaetzlichen Hinweis: *"Optional: `/claudemd-optimize` laufen lassen, um die frisch angelegte CLAUDE.md gegen die 8 Prinzipien pruefen zu lassen."* Keine automatische Ausfuehrung, keine Dependency.

- **Staerken:**
  - Minimal-invasiv: +2 Zeilen in SKILL.md.
  - User lernt das komplementaere Werkzeug kennen.
  - Skill bleibt standalone funktional, kein Pflicht-Coupling.
  - Folgt Olivers globaler CLAUDE.md-Regel "Nach jedem Kundenprojekt: Learnings zurueck in den Blueprint" — als Mikro-Variante davon.
- **Schwaechen:**
  - Inflation-Risiko: Wenn jeder Skill am Ende drei "ueberleg ob du auch X machen willst"-Hinweise gibt, wird Phase 5 zum Meta-Rauschen.
  - Schwache Kopplung: User kann den Befehl weiterhin ignorieren.
- **Schatten:** Der Hinweis wird zum "immer uebersprungen"-Ritual, wenn er auftaucht ohne erkennbaren Mehrwert. Wie ein "Cookie akzeptieren"-Banner.

**Aufwand:** Minimal (~3 Z. SKILL.md Erweiterung). Eleganz: hoch. Risiko: Hinweis-Rauschen.

### Variante 3 — Hard Integration (Phase 4 nutzt Prinzipien aus claudemd-optimize)

**Idee:** Phase 4 wird erweitert um ausgewaehlte Checks aus claudemd-optimize:
- Routing-Tabelle hat **3 Spalten** mindestens (Prinzip 4)
- CLAUDE.md enthaelt keine Persona-Zeilen (Prinzip 8 Anti-Pattern)
- Keine Prosa-Saetze > 3 Zeilen ohne Bullet-Struktur (Prinzip 4)
- Hierarchie-Summe pruefen (globale CLAUDE.md + rules + neue CLAUDE.md) — aber nur Warnung, kein Abbruch.

- **Staerken:**
  - Gebootstrappte Files landen von Anfang an in der guten Accuracy-Zone.
  - Weniger Arbeit fuer User nach Bootstrap.
- **Schwaechen:**
  - Skill waechst spuerbar (SKILL.md von 265 → 320+ Z. → selbst Prinzip-1-Verletzung).
  - Duplikation zwischen Skill-Phase-4 und Command — wenn Prinzip 4 sich weiterentwickelt, muessen beide Stellen gepflegt werden.
  - Template ist bereits prinzipien-konform designt — die meisten Checks wuerden leer laufen.
- **Schatten:** Klassisches DRY-Paradox. Beide Werkzeuge implementieren uebereinstimmende Logik, aber Sync-Kosten sind asymmetrisch: Jede Prinzip-Aenderung in claudemd-optimize muss in Skill nachgezogen werden, sonst Drift.

**Aufwand:** hoch (Skill-Wachstum + Sync-Last). Eleganz: mittel. Risiko: Prinzip-1-Selbstverletzung des Skills.

### Variante 4 — Phase 4 ruft Command auf

**Idee:** Phase 4 triggert am Ende automatisch `/claudemd-optimize` auf der neu erzeugten Datei. Reportergebnis wird in Phase 5 eingebettet.

- **Staerken:**
  - Zero extra User-Action, Full Qualitaet.
  - Single Source of Truth (Command, nicht Skill).
- **Schwaechen:**
  - Skill bekommt eine harte Dependency zu einem globalen Command, der nicht installiert sein muss.
  - Bootstrap dauert laenger (Command-Run + Report-Rendering).
  - Skill wird **Skill+Command-Orchestrator** — das ist Scope-Creep.
- **Schatten:** Skills koennen Commands nicht zuverlaessig triggern — Skill ist deklarativ, Command ist promptbasiert. Chain-Ausfuehrung hat keine offiziell dokumentierte Garantie, und bei Fehlschlag ist unklar ob Bootstrap gelungen oder nicht.

**Aufwand:** hoch, technisch unsauber. Eleganz: niedrig. Risiko: brittle Dependency.

---

## Ehrlicher Inversions-Check

**Was waere die schlechteste Entscheidung?** Variante 4 — Skill wird von einem globalen, unabhaengig gepflegten Command abhaengig, den der User vielleicht gar nicht hat. Das zerstoert die Skill-Portabilitaet (Public-Repo-Install → Command existiert nicht im anderen System → Skill bricht).

**Was waere die "elegantere Alternative", die noch nicht genannt wurde?**

- **Variante 5: claudemd-optimize lernt, auch CONTEXT.md und REFERENCES.md zu reviewen.** Dann ist der Command das einzige Review-Werkzeug fuer das gesamte Trio — und Phase 4 verweist darauf. Aber das ist Command-Erweiterung, nicht Skill-Integration, und liegt ausserhalb dieser Session.

Fuer diese Session: keine neue Variante noetig.

---

## Empfehlung

**Variante 2** ist die beste Balance.

- Loest das dokumentierte Risiko von Variante 1 (User kennt das Werkzeug nicht).
- Verletzt keine Skill-Prinzipien (Variante 3 wuerde Skill aufblaehen).
- Hat keine harte Dependency (Variante 4 ist brittle).
- Ist trivial reversibel — 3 Zeilen raus, wenn der Hinweis ignoriert wird.

**Konkrete Umsetzung (wenn Oliver zustimmt):**

In SKILL.md Phase 5, nach Punkt 4 "Drei konkrete naechste Schritte", ein neuer Punkt 5 ergaenzen:

```markdown
5. **Optionaler Qualitaets-Check:**
   > "Wenn du die CLAUDE.md noch mal pruefen lassen willst:
   > `/claudemd-optimize` laeuft ein Accuracy-Review nach 8 Prinzipien.
   > Nicht Pflicht — das Template ist prinzipien-konform. Nur wenn du
   > nach Anpassungen auf Nummer sicher gehen willst."
```

**Warum dieser Wortlaut:**
- Benennt den Mehrwert (8 Prinzipien, Accuracy).
- Sagt explizit "nicht Pflicht" — verhindert Banner-Muedigkeit.
- Nennt den Trigger (nach Anpassungen), nicht nach dem Bootstrap selbst — fuer frisches Template ist es redundant.

**Aufwand:** 3 Zeilen Skill-Aenderung, eine ADR 006 (optional) als Dokumentation der Entscheidung "Tools bleiben getrennt, soft handoff via Phase 5".

---

## Alternativ: claudemd-optimize erweitern

Eine orthogonale Beobachtung aus der Best-Practices-Recherche (Gap-A dort):

`claudemd-optimize` prueft heute nur CLAUDE.md-Dateien. In der Meta-Architektur ist die interessantere Entity das **Trio** — CLAUDE + CONTEXT + REFERENCES zusammen. Eine Erweiterung `/trio-optimize` oder `/claudemd-optimize --all` koennte alle drei Files zusammen reviewen (mit unterschiedlichen Prinzipien pro Datei).

Dies ist keine Skill-Aenderung, sondern eine Command-Erweiterung und liegt ausserhalb der aktuellen Session. Hier nur als Follow-up-Idee vermerkt.

---

## Quellen

- `C:\Users\olisc\Claude\meta-architektur\skill\project-bootstrap\SKILL.md`
- `C:\Users\olisc\.claude\commands\claudemd-optimize.md`
- Memory-Eintrag "/claudemd-optimize Command" (Lotus-Ion-Memory)
