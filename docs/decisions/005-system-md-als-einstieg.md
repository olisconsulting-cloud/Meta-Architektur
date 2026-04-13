# ADR 005: SYSTEM.md als optionaler One-Pager-Einstieg

Datum: 2026-04-13 | Status: accepted | Superseded by: —

## Kontext

Bei ausgereiften Workspaces (mehrere ADRs, Plan V4, Matrix, GLOSSARY, Templates) entsteht ein Problem fuer Neueinsteiger: Mehrere Files sind noetig, um das System zu verstehen. Einstieg ist haeufiger als Vertiefung, aber teurer. Plan V4 liefert die Vollversion, Matrix das Nachschlagewerk — aber keine destillierte Einstiegs-Sicht.

## Entscheidung

**SYSTEM.md wird als One-Pager angelegt — optional, komplementaer zu Plan V4, nicht ersetzend.**

- Ort: Workspace-Root
- Hartes Limit: 80 Zeilen
- Inhalt: Was / Warum / Wie (Drei Schichten) / Wann benutze ich was / Wo sind Details
- Routing-Eintrag in Workspace-CLAUDE.md als erste Tabellenzeile (hoechste Einstiegs-Prioritaet)
- **Nur anlegen wenn der Workspace >=5 Substanz-Files hat** (sonst Vorab-Perfektion)

## Begruendung

**Warum One-Pager zusaetzlich zu Plan V4.** Plan V4 bleibt die Vollversion — Tabellen, Anti-Patterns, Verifikations-Tests. Aber Plan V4 ist Lese-Aufwand fuer jemanden, der nur "was ist das" beantwortet bekommen will. SYSTEM.md bedient die 80%-Einstiegs-Frage mit 20% Material.

**Warum genau 80 Zeilen.** 40 Zeilen erzwingen Verzicht auf entweder die drei Schichten oder die Szenarien-Sektion — beides ist Kern-Nutzen. 150 Zeilen wuerden Plan V4 duplizieren und den Hebel zerstoeren. 80 ist empirisch der Sweet-Spot fuer "in 3 Minuten lesbar + alle drei Schichten abgedeckt + Einstiegs-typische Szenarien".

**Warum nicht in jedes Template-Bootstrap.** Skool-Anti-Pattern #7 (komplettes System bauen bevor nutzen). Erst wenn ein Workspace substanziell gewachsen ist, rechtfertigt sich die Destillation.

## Konsequenz

- SYSTEM.md ist Living Document — bei Systemaenderungen sofort fixen
- Wenn SYSTEM.md doch veraltet, ist das Signal fuer tiefergehenden System-Wandel (ADR-wuerdig)
- Im Bootstrap-Template bleibt SYSTEM.md **nicht** enthalten — nur die 4 Pflicht-Files + decisions/TEMPLATE.md

## Wartungs-Trigger (Pflicht wenn SYSTEM.md existiert)

SYSTEM.md beschreibt das System, diese ADR regelt wie SYSTEM.md gepflegt wird.

- **Bei jedem neuen ADR (006+):** Mini-ADR-Index in SYSTEM.md ergaenzen. Pruefen ob "Wann benutze ich was"-Tabelle oder "Drei Schichten"-Abschnitt angepasst werden muss.
- **Bei Umbenennung/Verschiebung von Pfaden:** alle Pfad-Referenzen in SYSTEM.md grep-pruefen und fixen.
- **Bei strukturellem Wandel (neue Schicht, geaenderte Zonen-Zahl):** SYSTEM.md ist kein Patch-Target mehr — neue ADR schreiben, die SYSTEM.md-Revision dokumentiert.
- **Wer prueft:** Verantwortlich ist Schreiber der ausloesenden ADR. Teil des ADR-Schreib-Rituals, nicht separater Task.
