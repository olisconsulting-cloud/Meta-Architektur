#!/usr/bin/env bash
# install.sh — Meta-Architektur Skill-Installer
# Kopiert den Skill nach ~/.claude/skills/project-bootstrap/
# und schreibt den Template-Pfad in .config

set -euo pipefail

# Repo-Root ermitteln: Script-Verzeichnis, auch ohne git
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$REPO_ROOT/skill/project-bootstrap"
TEMPLATE_SRC="$REPO_ROOT/template/project-skeleton"

# Ziel-Verzeichnis: ~/.claude/skills/project-bootstrap
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILL_DEST="$CLAUDE_HOME/skills/project-bootstrap"

echo "=== Meta-Architektur Skill-Installer ==="
echo ""

# Sanity-Checks
if [ ! -d "$SKILL_SRC" ]; then
  echo "FEHLER: Skill-Quelle nicht gefunden: $SKILL_SRC"
  echo "        Laeuft install.sh aus dem Repo-Root?"
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

mkdir -p "$CLAUDE_HOME/skills"

# Ueberschreibungs-Frage bei existierendem Skill
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

# Template-Pfad in .config schreiben
cat > "$SKILL_DEST/.config" <<EOF
META_ARCH_TEMPLATE_PATH=$TEMPLATE_SRC
EOF

# Bestaetigung
echo ""
echo "OK Skill installiert: $SKILL_DEST"
echo "OK Template-Pfad: $TEMPLATE_SRC"
echo ""
echo "Naechste Schritte:"
echo "  1. Claude Code im Ziel-Projekt oeffnen"
echo "  2. 'neues Projekt bootstrappen' tippen"
echo "  3. Skill fuehrt durch 6 Fragen, legt Workspace an"
echo ""
echo "Dokumentation: $REPO_ROOT/README.md"
