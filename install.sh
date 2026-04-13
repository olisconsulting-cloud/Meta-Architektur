#!/usr/bin/env bash
# install.sh — Meta-Architektur Installer
# Kopiert den Skill nach ~/.claude/skills/project-king/ und
# den Slash-Command nach ~/.claude/commands/project-king.md
# Schreibt den Template-Pfad in .config des Skill-Ordners.

set -euo pipefail

# Repo-Root ermitteln: Script-Verzeichnis, auch ohne git
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$REPO_ROOT/skill/project-king"
COMMAND_SRC="$REPO_ROOT/command/project-king.md"
TEMPLATE_SRC="$REPO_ROOT/template/project-skeleton"

# Ziel-Verzeichnisse
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILL_DEST="$CLAUDE_HOME/skills/project-king"
COMMAND_DEST="$CLAUDE_HOME/commands/project-king.md"

# Optional: alten project-bootstrap-Skill aufraeumen (Legacy vor v3)
LEGACY_SKILL="$CLAUDE_HOME/skills/project-bootstrap"

echo "=== Meta-Architektur Installer ==="
echo ""

# Sanity-Checks
if [ ! -d "$SKILL_SRC" ]; then
  echo "FEHLER: Skill-Quelle nicht gefunden: $SKILL_SRC"
  echo "        Laeuft install.sh aus dem Repo-Root?"
  exit 1
fi

if [ ! -f "$COMMAND_SRC" ]; then
  echo "FEHLER: Command-Quelle nicht gefunden: $COMMAND_SRC"
  echo "        Repo unvollstaendig?"
  exit 1
fi

if [ ! -d "$TEMPLATE_SRC" ]; then
  echo "FEHLER: Template-Quelle nicht gefunden: $TEMPLATE_SRC"
  echo "        Repo unvollstaendig?"
  exit 1
fi

if [ ! -d "$CLAUDE_HOME" ]; then
  echo "FEHLER: Claude-Verzeichnis nicht gefunden: $CLAUDE_HOME"
  echo "        Ist Claude Code installiert?"
  exit 1
fi

mkdir -p "$CLAUDE_HOME/skills" "$CLAUDE_HOME/commands"

# Legacy-Cleanup (alter Skill-Name aus v1/v2)
if [ -d "$LEGACY_SKILL" ]; then
  echo "HINWEIS: Alter Skill 'project-bootstrap' gefunden unter $LEGACY_SKILL"
  read -r -p "Entfernen? (j/n) " legacy_answer
  if [ "$legacy_answer" = "j" ] || [ "$legacy_answer" = "ja" ] || [ "$legacy_answer" = "y" ] || [ "$legacy_answer" = "yes" ]; then
    rm -rf "$LEGACY_SKILL"
    echo "OK Legacy-Skill entfernt."
  fi
fi

# Skill-Ueberschreibungs-Frage
if [ -d "$SKILL_DEST" ]; then
  echo "HINWEIS: Skill existiert bereits unter $SKILL_DEST"
  read -r -p "Ueberschreiben? (j/n) " answer
  if [ "$answer" != "j" ] && [ "$answer" != "ja" ] && [ "$answer" != "y" ] && [ "$answer" != "yes" ]; then
    echo "Abbruch — nichts veraendert."
    exit 0
  fi
  rm -rf "$SKILL_DEST"
fi

# Skill kopieren
cp -r "$SKILL_SRC" "$SKILL_DEST"

# Command kopieren (silent overwrite — Slash-Commands sind schmal, Ueberschreibung unkritisch)
cp "$COMMAND_SRC" "$COMMAND_DEST"

# Template-Pfad in .config schreiben
cat > "$SKILL_DEST/.config" <<EOF
META_ARCH_TEMPLATE_PATH=$TEMPLATE_SRC
EOF

# Bestaetigung
echo ""
echo "OK Skill installiert:   $SKILL_DEST"
echo "OK Command installiert: $COMMAND_DEST"
echo "OK Template-Pfad:       $TEMPLATE_SRC"
echo ""
echo "Aktivierung auf drei Wegen:"
echo "  1. /project-king           (Slash-Command)"
echo "  2. 'neues Projekt bootstrappen'  (Keyword-Phrase)"
echo "  3. 'nutze den project-king Skill' (explizit)"
echo ""
echo "Dokumentation: $REPO_ROOT/README.md"
