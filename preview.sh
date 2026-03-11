#!/bin/bash
# Figure 5 palette preview
# Usage: bash /tmp/figure5_palette.sh [warm|cool]  (default: warm)

MODE="${1:-warm}"

if [[ "$MODE" == "cool" ]]; then
  BG="28;28;28"
  FG="216;221;228"       # #D8DDE4
  C_WHITE="196;206;216"  # #C4CED8
  C_BWHITE="224;234;240" # #E0EAF0
  VARIANT="figure5-cool"
else
  BG="30;27;25"
  FG="240;224;184"       # #F0E0B8
  C_WHITE="205;186;144"  # #CDBA90
  C_BWHITE="250;240;208" # #FAF0D0
  VARIANT="figure5-warm-charcoal"
fi

C_BLACK="28;10;12";      C_BBLACK="138;100;72"
C_RED="204;34;17";       C_BRED="255;51;34"
C_GREEN="108;178;0";     C_BGREEN="142;212;0"
C_YELLOW="224;150;26";   C_BYELLOW="255;184;32"
C_BLUE="72;120;200";     C_BBLUE="80;128;208"
C_MAGENTA="184;64;120";  C_BMAGENTA="192;72;128"
C_CYAN="90;144;160";     C_BCYAN="104;168;184"

b()  { printf "\033[48;2;${1}m"; }
f()  { printf "\033[38;2;${1}m"; }
r()  { printf "\033[0m"; }
nl() { printf "\n"; }

swatch() {
  local rgb="$1" hex="$2" label="$3"
  b "$rgb"; printf "        "; r
  f "160;130;80"; printf " %-14s" "$label"; r
  f "200;170;110"; printf "%s" "$hex"; r
}

pair_row() {
  local l1="$1" h1="$2" c1="$3" l2="$4" h2="$5" c2="$6"
  printf "    "; swatch "$c1" "$h1" "$l1"
  printf "    "; swatch "$c2" "$h2" "$l2"
  nl
}

gold() { f "224;150;26"; printf "$*"; r; }
dim()  { f "100;70;40";  printf "$*"; r; }

nl
b "$BG"; f "224;150;26"
printf "  ═══════════════════════════════════════════════════════════════  "
r; nl
b "$BG"; f "$FG"
printf "     I SAW THE FIGURE "
b "$BG"; f "255;184;32"; printf "  5  "
b "$BG"; f "$FG"; printf " IN GOLD"
f "224;150;26"; printf "   ·   "
f "$FG"; printf "%s    " "$VARIANT"
r; nl
b "$BG"; f "224;150;26"
printf "  ═══════════════════════════════════════════════════════════════  "
r; nl; nl

printf "  "; gold "Base Colors"; nl
dim "  ─────────────────────────────────────────────────────────────────"; nl
printf "    "; swatch "$BG"       "variant"            "Background"; nl
printf "    "; swatch "$FG"       "variant"            "Foreground"; nl
printf "    "; swatch "$C_BWHITE"  "variant"            "Cursor"; nl
printf "    "; swatch "92;26;26"  "#5C1A1A"            "Selection"; nl
nl

printf "  "; gold "ANSI Colors"
f "100;70;40"; printf "                          standard → bright"; r; nl
dim "  ─────────────────────────────────────────────────────────────────"; nl
pair_row "Black"   "#1C0A0C" "$C_BLACK"   "Bright Black"   "#8A6448"  "$C_BBLACK"
pair_row "Red ♥"   "#CC2211" "$C_RED"     "Bright Red"     "#FF3322"  "$C_BRED"
pair_row "Green"   "#6CB200" "$C_GREEN"   "Bright Green"   "#8ED400"  "$C_BGREEN"
pair_row "Yellow"  "#E0961A" "$C_YELLOW"  "Bright Yellow"  "#FFB820"  "$C_BYELLOW"
pair_row "Blue"    "#4878C8" "$C_BLUE"    "Bright Blue"    "#5080D0"  "$C_BBLUE"
pair_row "Magenta" "#B84078" "$C_MAGENTA" "Bright Magenta" "#C04880"  "$C_BMAGENTA"
pair_row "Cyan"    "#5A90A0" "$C_CYAN"    "Bright Cyan"    "#68A8B8"  "$C_BCYAN"
pair_row "White"   "variant" "$C_WHITE"   "Bright White"   "variant"  "$C_BWHITE"
nl

printf "  "; gold "Syntax Preview"; nl
dim "  ─────────────────────────────────────────────────────────────────"; nl
b "$BG"; f "$FG"; printf "  The rain came down in buckets — I saw the figure 5 in gold"; nl
b "$BG"; f "$C_BBLUE";    printf "  // The Great Figure — by William Carlos Williams"; nl
b "$BG"; f "$C_BGREEN";   printf "  fn "; f "$C_BYELLOW"; printf "main"; f "$FG"; printf "() {"; nl
b "$BG"; f "$C_CYAN";     printf "    let "; f "$C_BWHITE"; printf "figure "; f "$FG"
printf "= "; f "$C_BRED"; printf "5"; f "$FG"; printf ";"; nl
b "$BG"; f "$C_CYAN";     printf "    let "; f "$C_WHITE";  printf "color  "; f "$FG"
printf "= "; f "$C_GREEN"; printf "\"gold\""; f "$FG"; printf ";"; nl
b "$BG"; f "$C_BMAGENTA"; printf "    #[derive("; f "$C_BYELLOW"; printf "Debug"
f "$C_BMAGENTA"; printf ")]"; nl
b "$BG"; f "$C_CYAN";     printf "    let "; f "$C_BWHITE"; printf "rain   "
f "$FG"; printf "= "; f "$C_BBLUE"; printf "true"; f "$FG"; printf ";  "
f "$C_BBLACK"; printf "// gong clangs"; nl
b "$BG"; f "$FG"; printf "  }"; r; nl; nl
