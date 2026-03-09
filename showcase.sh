#!/usr/bin/env bash
# Figure 5 — theme showcase
# Usage: bash showcase.sh [warm|softer|cool]

MODE="${1:-warm}"

case "$MODE" in
  cool)
    BG="28;28;28"; FG="216;221;228"
    C_WHITE="196;206;216"; C_BWHITE="224;234;240"
    VARIANT="figure5-cool"
    ;;
  softer)
    BG="37;34;32"; FG="240;224;184"
    C_WHITE="205;186;144"; C_BWHITE="250;240;208"
    VARIANT="figure5-softer-warm"
    ;;
  *)
    BG="30;27;25"; FG="240;224;184"
    C_WHITE="205;186;144"; C_BWHITE="250;240;208"
    VARIANT="figure5-warm-charcoal"
    ;;
esac

C_BLACK="28;10;12";     C_BBLACK="138;100;72"
C_RED="204;34;17";      C_BRED="255;51;34"
C_GREEN="108;178;0";    C_BGREEN="142;212;0"
C_YELLOW="224;150;26";  C_BYELLOW="255;184;32"
C_BLUE="72;120;200";    C_BBLUE="80;128;208"
C_MAGENTA="184;64;120"; C_BMAGENTA="192;72;128"
C_CYAN="90;144;160";    C_BCYAN="104;168;184"

b()  { printf "\033[48;2;${1}m"; }
f()  { printf "\033[38;2;${1}m"; }
r()  { printf "\033[0m"; }
nl() { printf "\n"; }

W=72

hrule() { f "70;55;38"; printf "  "; printf '─%.0s' $(seq 1 $W); r; nl; }

sec() {
  nl
  b "$BG"; f "$C_BYELLOW"; printf "  %-${W}s  " "$*"; r; nl
  hrule
}

clear
nl

# ═══ Title banner ════════════════════════════════════════════════════════
b "$BG"; f "$C_YELLOW"; printf "  "; printf '═%.0s' $(seq 1 $W); printf "  "; r; nl
b "$BG"
f "$FG";       printf "     I SAW THE FIGURE "
f "$C_BYELLOW"; printf "  5  "
f "$FG";       printf " IN GOLD"
f "$C_YELLOW"; printf "   ·   "
f "$C_WHITE";  printf "%s" "$VARIANT"
printf "%$((W - 38 - ${#VARIANT}))s  "
r; nl
b "$BG"; f "$C_YELLOW"; printf "  "; printf '═%.0s' $(seq 1 $W); printf "  "; r; nl

# ═══ Section 1: Ghostty palette ══════════════════════════════════════════
sec "GHOSTTY  —  terminal palette"

pair_row() {
  local c1="$1" l1="$2" h1="$3"  c2="$4" l2="$5" h2="$6"
  printf "    "
  b "$c1"; printf "      "; r
  f "160;130;80"; printf "  %-13s" "$l1"
  f "110;85;55";  printf "%-9s" "$h1"
  printf "    "
  b "$c2"; printf "      "; r
  f "160;130;80"; printf "  %-13s" "$l2"
  f "110;85;55";  printf "%-9s" "$h2"
  r; nl
}

pair_row "$C_BLACK"   "Black"   "#1C0A0C"  "$C_BBLACK"   "Br Black"   "#8A6448"
pair_row "$C_RED"     "Red"     "#CC2211"  "$C_BRED"     "Br Red"     "#FF3322"
pair_row "$C_GREEN"   "Green"   "#6CB200"  "$C_BGREEN"   "Br Green"   "#8ED400"
pair_row "$C_YELLOW"  "Yellow"  "#E0961A"  "$C_BYELLOW"  "Br Yellow"  "#FFB820"
pair_row "$C_BLUE"    "Blue"    "#4878C8"  "$C_BBLUE"    "Br Blue"    "#5080D0"
pair_row "$C_MAGENTA" "Magenta" "#B84078"  "$C_BMAGENTA" "Br Magenta" "#C04880"
pair_row "$C_CYAN"    "Cyan"    "#5A90A0"  "$C_BCYAN"    "Br Cyan"    "#68A8B8"
pair_row "$C_WHITE"   "White"   "variant"  "$C_BWHITE"   "Br White"   "variant"

# ═══ Section 2: Helix editor ═════════════════════════════════════════════
sec "HELIX  —  editor syntax preview"

code_ln() {
  local num="$1"; shift
  b "$BG"; f "$C_BBLACK"; printf " %3s  " "$num"; r; b "$BG"
  printf "%s" "$*"
  r; nl
}

code_ln 1  "$(f "$C_BBLUE")// The Great Figure · William Carlos Williams$(r)"
code_ln 2  ""
code_ln 3  "$(f "$C_BGREEN")use $(f "$C_CYAN")std::io$(f "$FG");$(r)"
code_ln 4  ""
code_ln 5  "$(f "$C_BMAGENTA")#[derive($(f "$C_BYELLOW")Debug, Clone$(f "$C_BMAGENTA"))]$(r)"
code_ln 6  "$(f "$C_BGREEN")struct $(f "$C_BYELLOW")Figure $(f "$FG"){ $(f "$C_CYAN")value$(f "$FG"): $(f "$C_CYAN")u8$(f "$FG") }$(r)"
code_ln 7  ""
code_ln 8  "$(f "$C_BGREEN")fn $(f "$C_BYELLOW")render$(f "$FG")($(f "$C_CYAN")ctx$(f "$FG"): &mut $(f "$C_CYAN")Context$(f "$FG")) {$(r)"
code_ln 9  "    $(f "$C_CYAN")let $(f "$C_BWHITE")gold $(f "$FG")= $(f "$C_BRED")5$(f "$FG");    $(f "$C_BBLACK")// the figure in gold$(r)"
code_ln 10 "    $(f "$C_CYAN")let $(f "$C_WHITE")rain $(f "$FG")= $(f "$C_BBLUE")true$(f "$FG");$(r)"
code_ln 11 "    $(f "$C_CYAN")let $(f "$C_WHITE")name $(f "$FG")= $(f "$C_GREEN")\"gold\"$(f "$FG");$(r)"
code_ln 12 "}$(r)"

# statusline
b "40;35;30"; f "$C_BRED";   printf " NOR "
b "50;44;38"; f "$C_BWHITE"; printf "  figure.rs "
b "$BG";      f "$C_BBLACK"; printf "                          "
f "$C_YELLOW"; printf "  12:1  "
f "$C_BBLACK"; printf "  Rust  "
f "$C_CYAN";   printf "  %s  " "$VARIANT"
r; nl

# ═══ Section 3: k9s pod view ═════════════════════════════════════════════
sec "K9S  —  Kubernetes pod listing"

# Column header
b "40;35;30"; f "$C_YELLOW"
printf "  %-22s %-6s %-11s %-10s %s%$((W - 57))s" \
  "NAME" "READY" "STATUS" "RESTARTS" "AGE" ""
r; nl

pod() {
  local name="$1" ready="$2" status="$3" restarts="$4" age="$5" sc="$6"
  b "$BG"
  f "$FG";      printf "  %-22s " "$name"
  f "$C_WHITE"; printf "%-6s " "$ready"
  f "$sc";      printf "%-11s " "$status"
  f "$C_WHITE"; printf "%-10s " "$restarts"
  f "$C_BBLACK"; printf "%s" "$age"
  r; nl
}

pod "api-server-7d9f8b"    "1/1" "Running"   "0" "3d"  "$C_BWHITE"
pod "worker-6c4d9-xk2lp"   "1/1" "Running"   "0" "3d"  "$C_BWHITE"
pod "cache-redis-0"         "1/1" "Running"   "2" "3d"  "$C_BWHITE"
pod "db-migrate-4xj9k"      "0/1" "Completed" "0" "1h"  "$C_BBLACK"
pod "ingress-ctrl-59f7"     "0/1" "Error"     "5" "45m" "$C_BRED"
pod "metrics-84b5c-7lp"     "1/1" "Running"   "0" "2d"  "$C_BWHITE"
pod "auth-svc-d87c2-nnpqr"  "0/1" "Pending"   "0" "8m"  "$C_YELLOW"

# ═══ Footer ══════════════════════════════════════════════════════════════
nl
b "$BG"; f "$C_YELLOW"; printf "  "; printf '═%.0s' $(seq 1 $W); printf "  "; r; nl
nl
