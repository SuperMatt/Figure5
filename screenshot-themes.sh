#!/usr/bin/env bash
# Figure 5 — open Ghostty windows per theme variant and screenshot each
#
# Usage: bash screenshot-themes.sh [output-dir]
#   output-dir  defaults to ./screenshots
#
# Showcases: terminal palette, Helix editor syntax, k9s pod listing
# Requirements: ghostty (themes installed via make ghostty), and one of:
#   cosmic-screenshot  (COSMIC desktop)
#   gnome-screenshot   (GNOME)
#   grim               (Sway / Hyprland)
#   scrot              (X11)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${1:-$SCRIPT_DIR/screenshots}"
SHOWCASE="$SCRIPT_DIR/showcase.sh"

mkdir -p "$OUT_DIR"

# ── detect screenshot tool ────────────────────────────────────────────────
detect_screenshot_tool() {
  if command -v cosmic-screenshot &>/dev/null; then
    echo "cosmic-screenshot"
  elif command -v gnome-screenshot &>/dev/null; then
    echo "gnome-screenshot"
  elif command -v grim &>/dev/null; then
    echo "grim"
  elif command -v scrot &>/dev/null; then
    echo "scrot"
  else
    echo ""
  fi
}

SCREENSHOT_TOOL="$(detect_screenshot_tool)"

if [[ -z "$SCREENSHOT_TOOL" ]]; then
  echo "ERROR: no screenshot tool found." >&2
  echo "" >&2
  echo "Install one of:" >&2
  echo "  cosmic-screenshot  (COSMIC desktop)" >&2
  echo "  sudo dnf install gnome-screenshot" >&2
  echo "  sudo dnf install grim              # Sway / Hyprland" >&2
  echo "  sudo dnf install scrot             # X11 only" >&2
  exit 1
fi

echo "Using screenshot tool: $SCREENSHOT_TOOL"
echo ""

screenshot() {
  local outfile="$1"
  case "$SCREENSHOT_TOOL" in
    cosmic-screenshot)
      local capdir; capdir="$(mktemp -d)"
      cosmic-screenshot --interactive=false --modal=false --notify=false \
        --save-dir "$capdir"
      local captured; captured="$(ls -t "$capdir"/*.png 2>/dev/null | head -1)"
      if [[ -n "$captured" ]]; then
        mv "$captured" "$outfile"
        rmdir "$capdir"
        echo "  saved → $outfile"
      else
        echo "  WARNING: cosmic-screenshot produced no output" >&2
      fi
      ;;
    gnome-screenshot) gnome-screenshot -f "$outfile" && echo "  saved → $outfile" ;;
    grim)             grim "$outfile"             && echo "  saved → $outfile" ;;
    scrot)            scrot "$outfile"            && echo "  saved → $outfile" ;;
  esac
}

# ── variants ──────────────────────────────────────────────────────────────
declare -A THEMES=(
  [warm]="figure5-warm-charcoal"
  [softer]="figure5-softer-warm"
  [cool]="figure5-cool"
)

# Temp config file — avoids --override parsing pitfalls and lets us set
# fullscreen cleanly. Written to home dir so Ghostty (host process) can read it.
GHOSTTY_CFG="$HOME/.figure5-screenshot.conf"

echo "Figure 5 — theme screenshots"
echo "Output: $OUT_DIR"
echo ""

for mode in warm softer cool; do
  theme="${THEMES[$mode]}"
  outfile="$OUT_DIR/${theme}.png"

  echo "[ $theme ]"

  cat > "$GHOSTTY_CFG" << EOF
theme = $theme
font-size = 13
fullscreen = true
gtk-single-instance = false
EOF

  echo "  launching Ghostty (fullscreen)..."

  # Run showcase then sleep to keep the window open for screenshotting.
  # The showcase exits in ~0.1s; sleep keeps Ghostty alive until we kill it.
  ghostty --config-file="$GHOSTTY_CFG" \
    -e bash -c "bash '$SHOWCASE' $mode; sleep 30" 2>/dev/null &
  GHOSTTY_PID=$!

  # Wait for Ghostty to start, go fullscreen, and render (~2s startup + margin)
  echo "  waiting for render (7s)..."
  sleep 7

  echo "  capturing..."
  screenshot "$outfile"

  kill "$GHOSTTY_PID" 2>/dev/null || true
  wait "$GHOSTTY_PID" 2>/dev/null || true
  sleep 0.5
  echo ""
done

rm -f "$GHOSTTY_CFG"

echo "Done. Screenshots:"
ls -1 "$OUT_DIR"/*.png 2>/dev/null | sed 's/^/  /'
