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

# Legacy-Cleanup (alter Skill-Name aus v1/v2 — idempotent, silent)
LEGACY_REMOVED=0
if [ -d "$LEGACY_SKILL" ]; then
  rm -rf "$LEGACY_SKILL"
  LEGACY_REMOVED=1
fi

# Skill-Update: bestehende Installation sichern (zeitstempel-Backup)
BACKUP_DEST=""
if [ -d "$SKILL_DEST" ]; then
  BACKUP_DEST="$SKILL_DEST.bak.$(date +%Y%m%d-%H%M%S)"
  mv "$SKILL_DEST" "$BACKUP_DEST"
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
if [ "$LEGACY_REMOVED" = "1" ]; then
  echo "OK Legacy-Skill 'project-bootstrap' entfernt"
fi
if [ -n "$BACKUP_DEST" ]; then
  echo "OK Vorheriger Skill gesichert: $BACKUP_DEST"
  echo "   (Alte Backups bei Bedarf loeschen: rm -rf $SKILL_DEST.bak.*)"
fi
echo ""
echo "Aktivierung auf drei Wegen:"
echo "  1. /project-king           (Slash-Command)"
echo "  2. 'neues Projekt bootstrappen'  (Keyword-Phrase)"
echo "  3. 'nutze den project-king Skill' (explizit)"
echo ""

# GSD (Get Shit Done) — Roadmap-System, empfohlener Partner fuer project-king
# Quelle: https://github.com/gsd-build/get-shit-done (MIT-Lizenz)
echo "=== GSD (Get Shit Done) — Roadmap-System ==="
echo ""
echo "GSD ergaenzt project-king: nach dem Workspace-Bootstrap hilft GSD bei"
echo "Requirements, Phasen und Roadmap. Offizieller Installer vom Hersteller."
echo ""
read -r -p "GSD jetzt zusaetzlich installieren? (j/n, default j): " gsd_answer
gsd_answer="${gsd_answer:-j}"

if [ "$gsd_answer" = "j" ] || [ "$gsd_answer" = "ja" ] || [ "$gsd_answer" = "y" ] || [ "$gsd_answer" = "yes" ]; then
  if ! command -v npx >/dev/null 2>&1; then
    echo "HINWEIS: npx nicht gefunden — Node.js/npm noetig fuer GSD-Installation."
    echo "         project-king ist trotzdem fertig installiert."
    echo "         GSD spaeter manuell: npx get-shit-done-cc@latest --claude --global"
  else
    echo "Installiere GSD via offiziellem Installer..."
    if npx -y get-shit-done-cc@latest --claude --global; then
      echo "OK GSD installiert."
    else
      echo "HINWEIS: GSD-Installation fehlgeschlagen. project-king ist trotzdem fertig."
      echo "         GSD spaeter manuell: npx get-shit-done-cc@latest --claude --global"
    fi
  fi
else
  echo "GSD uebersprungen. Spaeter manuell: npx get-shit-done-cc@latest --claude --global"
fi

echo ""
echo "Dokumentation: $REPO_ROOT/README.md"
