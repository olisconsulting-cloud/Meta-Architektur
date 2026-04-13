# Skill-Design — Kern-Fragen oder Schulungs-Prozess?

Datum: 2026-04-13 | Status: Design-Vorschlaege, keine Umsetzung entschieden

> **Namens-Hinweis:** Der Skill wurde am 2026-04-13 zu `project-king` umbenannt.
> Dieses Research-Dokument nennt noch den alten Namen `project-bootstrap` als
> Zeitpunkt-Snapshot. Inhalt gilt unveraendert fuer `project-king`.

## Frage

Der `project-bootstrap` Skill hat heute 6 Interview-Fragen (Name, Zone, Zweck, Task-Types, Audience, Erfolg) — klar, effizient, ca. 3 Minuten. Oliver ueberlegt: soll der Skill zu einem A-bis-Z-Schulungs-Prozess erweitert werden, der nebenbei die Meta-Architektur-Prinzipien lehrt?

## Ausgangslage

**Was die 6 Fragen heute leisten:**
- Erzeugen einen vollstaendigen, produktionsreifen Workspace.
- Blocken den Skool-Fehler #7 ("komplettes System bauen bevor nutzen") strukturell — User kann nicht weitermachen ohne Substanz.
- Jede Frage triggert genau eine Entscheidung mit sichtbarer Konsequenz im Template.

**Was die 6 Fragen heute NICHT leisten:**
- Sie erklaeren nicht, **warum** die Drei-Datei-Architektur so aussieht.
- Sie verweisen nicht auf Plan V4 oder ADRs.
- Ein Erst-User bekommt einen Workspace, aber kein Verstaendnis.

**Was Oliver potenziell will:**
- Der Skill soll nicht nur eine Maschine fuer Output sein, sondern ein Vehikel fuer das Mental-Modell.
- Der Prozess soll den User durch die **Prinzipien** fuehren, nicht nur durch die **Felder**.

---

## Drei Varianten

### Variante A — Status quo (6 Fragen, Kern-Modus)

**Flow:** 6 Fragen, Bestaetigung, Write, Phase 5 Abschluss. Heute. ~3 Minuten.

- **Staerken:**
  - Skool-Prinzip #7 erfuellt: kleinster sinnvoller Start.
  - Skill bleibt kompakt (265 Z. SKILL.md, triggert zuverlaessig).
  - Wiederholte User kommen schnell durch.
  - Klare Trennung: Skill liefert Struktur, externes Material (Plan V4, Lektionen) liefert Verstaendnis.
- **Schwaechen:**
  - Erst-User bekommt keinen pedagogischen Wert.
  - Warum-Fragen bleiben offen, User muss sie aktiv recherchieren.
- **Schatten:**
  - Risiko, dass User den Skill nutzt, ohne das System zu verstehen → Living-Document-Disziplin wird ignoriert → Workspaces verfallen leise.
  - Oliver merkt moeglicherweise erst Monate spaeter, dass 50% der gebootstrappten Workspaces nicht nach Architektur-Prinzipien gepflegt werden.

### Variante B — Schulungs-Prozess (A-bis-Z, Lern-Modus als einziger Modus)

**Flow:** 12-18 Fragen. Nach jeder inhaltlichen Frage ein 2-3-Satz-Lernhaeppchen (z.B. "Warum ist die Routing-Tabelle Pflicht? Weil Skool Fehler #2 belegt: ohne sie raet Claude..."). Abschluss mit Mini-Quiz ("Welche Datei laedt automatisch, welche task-basiert?").

- **Staerken:**
  - User versteht das System, nicht nur die Struktur.
  - Skill wird Marketing-Vehikel — wer bootstrapt, lernt die Lehre kennen.
  - Weniger Folge-Fragen ("warum kebab-case?") im spaeteren Verlauf.
- **Schwaechen:**
  - Bootstrap dauert 10-15 Minuten statt 3. Skool-Fehler #7 naeher.
  - Wiederkehrende User zahlen Schulungs-Kosten bei jeder Nutzung.
  - Skill waechst auf 500+ Zeilen SKILL.md — selbst Prinzip-1-Verletzung, Triggern wird unzuverlaessig.
  - Pedagogische Inhalte sind **dupliziert** mit Plan V4, Skool-Zitate-Doc, Glossary — Drift-Gefahr.
- **Schatten:**
  - Oliver nutzt Skill 10x haeufiger als alle anderen User zusammen → Oliver zahlt die Schulungs-Kosten am oeftesten, gewinnt aber am wenigsten (er kennt das System).
  - Bei 3-Mann-Team mit wiederholtem Bootstrapping: Skill wird **umgangen** ("ich kopiere das Template manuell, ist schneller").

### Variante C — Hybrid: Quick-Modus + Lern-Modus

**Flow:** Phase 0 hat heute bereits eine Weiche ("neu oder bestehend?"). Ergaenzt um zweite Weiche:

> "Kennst du die Meta-Architektur schon? (j = Quick-Modus, 6 Fragen, 3 Min | n = Lern-Modus, mit Erklaerungen, 10 Min)"

- Quick-Modus: heutige 6 Fragen ohne Aenderung.
- Lern-Modus: gleiche 6 Fragen + pro Frage ein Lernhaeppchen aus Plan V4 / Skool-Zitaten. Keine zusaetzlichen Fragen, keine Quiz-Elemente.

- **Staerken:**
  - Wiederkehrende User (Oliver) zahlen keinen Overhead.
  - Erst-User bekommen pedagogischen Wert.
  - Kein Fragen-Creep: gleiche 6 Fragen in beiden Modi, nur Rahmung unterschiedlich.
  - Lern-Modus ist optional — wer die Fragen kennt, aber ein Refresher will, nimmt ihn auch beim 3. Mal.
- **Schwaechen:**
  - Skill waechst um 60-80 Z. (SKILL.md 265 → 340-350 Z.).
  - Doppelte Pflege: Wenn ein Prinzip sich aendert, muessen Plan V4 **und** Skill-Lernhaeppchen gepflegt werden.
  - Weiche am Anfang ist eine zusaetzliche Entscheidung, die User auch falsch treffen koennen ("ich dachte ich kenne das schon, aber war nur bei Frage 4 unsicher").
- **Schatten:**
  - Die Lernhaeppchen koennten in 6 Monaten von Plan V4 driften → User bekommt veraltete Lehre. Risiko mitigierbar durch **Pointer** statt Kopien: Lernhaeppchen ist 1 Satz Essenz + `siehe docs/plan-v4.md#abschnitt-X`.

---

## Inversions-Check

**Was waere das genaue Gegenteil, und ist es besser?**

**Inverse:** Skill entfernt sogar die 6 Fragen — Template wird einfach kopiert, User fuellt es manuell (wie `create-next-app`).

- Vorteil: Skill waere extrem schlank (50 Z.), kein Interview-Overhead.
- Nachteil: Genau der Skool-Fehler #7 tritt ein — leere Platzhalter bleiben leer, Struktur ohne Substanz.

Inverse-Check bestaetigt: **Die 6 Fragen sind der Kern-Wert des Skills, sie duerfen nicht geopfert werden.** Jede Variante muss sie erhalten.

**Zweiter Inverse:** Skill abschaffen, Lern-Material als getrenntes `docs/tutorial.md` publizieren.

- Vorteil: Klare Trennung von Produktion (Skill) und Lehre (Doc).
- Nachteil: User laesst Tutorial ungelesen, nur Skill-Output bleibt. Lehre erreicht niemanden.
- Fazit: Skill **ist** der Zugang zur Lehre — ein Tutorial ohne Skill-Kopplung wird nicht konsumiert.

---

## Empfehlung

**Variante C (Hybrid)** ist die beste Balance — aber mit Disziplin.

**Warum:**
- Skool-Fehler #7 wird respektiert (Quick-Modus ist Default fuer Wiederkehr).
- Erst-User bekommen Lehre, ohne dass Oliver bei jeder Nutzung Schulungs-Overhead zahlt.
- Lernhaeppchen als **Pointer** zu Plan V4 / Skool-Zitate — keine Doppel-Pflege, kein Drift-Risiko.
- Erweiterung ist additiv zu ADR 003 (Trio-Pflicht), kein Superseding.

**Umsetzung (wenn Oliver zustimmt):**

1. Phase 0 erweitern um Modus-Weiche (heutige Migrations-Weiche + Lern-Weiche).
2. Fuer jede der 6 Fragen in Phase 1 ein 1-Satz-Lernhaeppchen + Pointer definieren. Inhalte nicht duplizieren, nur verlinken.
3. Im Quick-Modus: Lernhaeppchen werden uebersprungen (leerer Branch).
4. Neue ADR 006: "Skill-Dual-Mode als Default — Quick + Lern, Lehre als Pointer."
5. SKILL.md waechst um ~60-80 Z. auf ca. 340 Z. Selbst-Pruefung: bleibt das in der Skill-Zone? Ja, Skills haben keine Anthropic-Zeilen-Grenzen wie CLAUDE.md, nur Trigger-Description ist zeilenbegrenzt.

**Was NICHT passieren darf:**
- Lernhaeppchen werden zu Mini-Essays (>3 Z.) → waechst auf Variante B.
- Lernhaeppchen duplizieren Plan-V4-Inhalte → Drift.
- Quiz-Elemente oder "Bist du sicher?"-Checks → Reibung ohne Mehrwert.

**Tendenz (eine Meinung, nicht die Entscheidung):**
Der Hybrid ist elegant, aber loest **kein akutes Problem**. Wenn Oliver heute keine Anfrage von Erst-Usern hat ("ich verstehe das nicht"), ist Variante A weiter gerechtfertigt. Variante C wird interessant, sobald der Skill oeffentlich genutzt wird (Repo ist live auf GitHub, erster Stern kommt irgendwann). Fuer einen Pilotbetrieb: Variante A heute, Variante C **wenn** jemand aus der Community fragt "was macht der Skill eigentlich?".

---

## Entscheidungs-Checkliste fuer Oliver

- Gibt es aktuell User ausser dir? → Nein: Variante A. → Ja: Variante C.
- Willst du den Skill als Publikation / Talk / Tutorial nutzen? → Ja: Variante C.
- Hat der Quick-Modus aktuell Schmerzen (zu kompliziert, zu lang)? → Nein: Variante A bleibt.
- Willst du die Meta-Architektur einem Kunden erklaeren und der Skill soll das uebernehmen? → Variante C mit Lern-Modus als Default fuer Demo.

---

## Quellen

- `C:\Users\olisc\Claude\meta-architektur\skill\project-bootstrap\SKILL.md`
- `C:\Users\olisc\Claude\meta-architektur\skill\project-bootstrap\references\bootstrap-questions.md`
- `C:\Users\olisc\Claude\meta-architektur\docs\plan-v4.md`
- `C:\Users\olisc\Claude\meta-architektur\docs\skool-zitate.md` (Fehler #7)
- Memory "Vorschlag pruefen" (A/B/C mit Staerken/Schwaechen/Schatten)
