# herdr-app (Herdr Desktop) Theme Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Figure 5 themes for the Herdr desktop app (`herdr-app`), as three JSON files in `herdr-app/`, a `make herdr-app` install target, and doc updates.

**Architecture:** Pure data files following the app's own theme schema (`~/.config/herdr-app/themes/<name>.json`: `background`/`foreground`/`selection`/`cursor` + 16-color `ansi` array + optional `colors` UI-chrome map). Terminal layer copied verbatim from the matching `ghostty/` files; UI layer mapped per the committed spec (`docs/superpowers/specs/2026-11-02-herdr-app-theme-design.md`).

**Tech Stack:** JSON data files, GNU Make, Markdown docs. No code, no test framework — verification is JSON parsing plus palette cross-checks against the Ghostty sources.

## Global Constraints

- All colors are `#rrggbb` lowercase (app schema requirement).
- ANSI order is standard: indices 0-7 = black, red, green, yellow, blue, magenta, cyan, white; 8-15 = bright counterparts.
- Red `#CC2211` appears only as `blocked` and ansi1/ansi9 — never as a success/working color (repo rule: red means danger only).
- `selection` (terminal) and `selected` (UI) both use `#5C1A1A` for every variant.
- Theme file names: `figure5-warm-charcoal.json`, `figure5-softer-warm.json`, `figure5-cool.json`.
- Do not modify the existing `herdr/` terminal-server themes.
- Git: use `/usr/bin/git` (plain `git` is rtk-proxied and refused by the worktree hook in this session).

---

### Task 1: The three theme JSON files

**Files:**
- Create: `herdr-app/figure5-warm-charcoal.json`
- Create: `herdr-app/figure5-softer-warm.json`
- Create: `herdr-app/figure5-cool.json`

**Interfaces:**
- Consumes: palette values from `ghostty/figure5-warm-charcoal`, `ghostty/figure5-softer-warm`, `ghostty/figure5-cool`; surface tones from `herdr/figure5-warm-charcoal.toml`.
- Produces: three files consumed by the Makefile target in Task 2.

- [ ] **Step 1: Write `herdr-app/figure5-warm-charcoal.json`**

```json
{
  "background": "#1E1B19",
  "foreground": "#F0E0B8",
  "selection": "#5C1A1A",
  "cursor": "#FAF0D0",
  "ansi": [
    "#1C0A0C", "#CC2211", "#6CB200", "#E0CC1A", "#4878C8", "#B84078", "#5A90A0", "#CDBA90",
    "#8A6448", "#FF3322", "#78E000", "#FFD420", "#5080D0", "#C04880", "#68A8B8", "#FAF0D0"
  ],
  "colors": {
    "background": "#1E1B19",
    "foreground": "#F0E0B8",
    "surface": "#2A2623",
    "canvas": "#252220",
    "chrome": "#151210",
    "popover": "#35302C",
    "raised": "#2A2623",
    "hover": "#35302C",
    "selected": "#5C1A1A",
    "border": "#3D3732",
    "input": "#151210",
    "muted": "#CDBA90",
    "dim": "#8A6448",
    "accent": "#E0CC1A",
    "accent_foreground": "#1E1B19",
    "solid": "#E0CC1A",
    "solid_foreground": "#1E1B19",
    "selection": "#5C1A1A",
    "working": "#FFD420",
    "blocked": "#CC2211",
    "done": "#6CB200",
    "idle": "#8A6448",
    "unknown": "#8A6448"
  }
}
```

- [ ] **Step 2: Write `herdr-app/figure5-softer-warm.json`**

```json
{
  "background": "#252220",
  "foreground": "#F0E0B8",
  "selection": "#5C1A1A",
  "cursor": "#FAF0D0",
  "ansi": [
    "#1C0A0C", "#CC2211", "#6CB200", "#E0CC1A", "#4878C8", "#B84078", "#5A90A0", "#CDBA90",
    "#8A6448", "#FF3322", "#78E000", "#FFD420", "#5080D0", "#C04880", "#68A8B8", "#FAF0D0"
  ],
  "colors": {
    "background": "#252220",
    "foreground": "#F0E0B8",
    "surface": "#332E2A",
    "canvas": "#2B2724",
    "chrome": "#1B1816",
    "popover": "#3B3530",
    "raised": "#332E2A",
    "hover": "#3B3530",
    "selected": "#5C1A1A",
    "border": "#453E38",
    "input": "#1B1816",
    "muted": "#CDBA90",
    "dim": "#8A6448",
    "accent": "#E0CC1A",
    "accent_foreground": "#252220",
    "solid": "#E0CC1A",
    "solid_foreground": "#252220",
    "selection": "#5C1A1A",
    "working": "#FFD420",
    "blocked": "#CC2211",
    "done": "#6CB200",
    "idle": "#8A6448",
    "unknown": "#8A6448"
  }
}
```

- [ ] **Step 3: Write `herdr-app/figure5-cool.json`**

```json
{
  "background": "#1C1C1C",
  "foreground": "#D8DDE4",
  "selection": "#5C1A1A",
  "cursor": "#E0EAF0",
  "ansi": [
    "#1C0A0C", "#CC2211", "#6CB200", "#E0CC1A", "#4878C8", "#B84078", "#5A90A0", "#C4CED8",
    "#8A6448", "#FF3322", "#78E000", "#FFD420", "#5080D0", "#C04880", "#68A8B8", "#E0EAF0"
  ],
  "colors": {
    "background": "#1C1C1C",
    "foreground": "#D8DDE4",
    "surface": "#242424",
    "canvas": "#202020",
    "chrome": "#141414",
    "popover": "#2C2C2C",
    "raised": "#242424",
    "hover": "#2C2C2C",
    "selected": "#5C1A1A",
    "border": "#383838",
    "input": "#141414",
    "muted": "#C4CED8",
    "dim": "#77828C",
    "accent": "#E0CC1A",
    "accent_foreground": "#1C1C1C",
    "solid": "#E0CC1A",
    "solid_foreground": "#1C1C1C",
    "selection": "#5C1A1A",
    "working": "#FFD420",
    "blocked": "#CC2211",
    "done": "#6CB200",
    "idle": "#77828C",
    "unknown": "#77828C"
  }
}
```

- [ ] **Step 4: Verify JSON validity**

Run: `for f in herdr-app/*.json; do python3 -m json.tool "$f" > /dev/null && echo "OK $f"; done`
Expected: `OK` for all three files.

- [ ] **Step 5: Verify terminal layer matches Ghostty sources**

Run:
```bash
python3 - <<'EOF'
import re
for variant in ("warm-charcoal", "softer-warm", "cool"):
    ghost = open(f"ghostty/figure5-{variant}").read()
    pal = dict(re.findall(r"palette = (\d+)=#\w+", ghost))
    ansi = [pal[str(i)] for i in range(16)]
    want_bg = re.search(r"background = (#\w+)", ghost).group(1)
    want_fg = re.search(r"foreground = (#\w+)", ghost).group(1)
    want_sel = re.search(r"selection-background = (#\w+)", ghost).group(1)
    want_cur = re.search(r"cursor-color = (#\w+)", ghost).group(1)
    theme = __import__("json").load(open(f"herdr-app/figure5-{variant}.json"))
    lower = [c.lower() for c in theme["ansi"]]
    assert lower == [c.lower() for c in ansi], (variant, "ansi")
    assert theme["background"].lower() == want_bg.lower(), (variant, "bg")
    assert theme["foreground"].lower() == want_fg.lower(), (variant, "fg")
    assert theme["selection"].lower() == want_sel.lower(), (variant, "sel")
    assert theme["cursor"].lower() == want_cur.lower(), (variant, "cur")
print("all variants match ghostty sources")
EOF
```
Expected: `all variants match ghostty sources`.

- [ ] **Step 6: Commit**

```bash
/usr/bin/git add herdr-app
/usr/bin/git commit -m "Add herdr-app (desktop) themes, 3 variants"
```

---

### Task 2: Makefile target

**Files:**
- Modify: `Makefile` — four edits, exact locations below.

**Interfaces:**
- Consumes: `herdr-app/figure5-*.json` from Task 1.
- Produces: `make herdr-app` / `make uninstall-herdr-app` install/remove the three files in `~/.config/herdr-app/themes/`.

- [ ] **Step 1: Add `HERDR_APP_THEMES_DIR` variable**

In the variable block at the top, after the `CLAUDE_THEMES_DIR` line, add:

```make
HERDR_APP_THEMES_DIR := $(HOME)/.config/herdr-app/themes
```

- [ ] **Step 2: Add to `all` and `.PHONY`**

Change the `all:` line to:

```make
all: ghostty zed helix k9s zellij fresh claude herdr herdr-app vscode cursor
```

Change the `.PHONY:` line to:

```make
.PHONY: all ghostty zed helix k9s zellij fresh claude herdr herdr-app vscode cursor \
        uninstall-ghostty uninstall-zed uninstall-helix uninstall-k9s \
        uninstall-zellij uninstall-fresh uninstall-claude uninstall-herdr \
        uninstall-herdr-app uninstall-vscode uninstall-cursor \
        preview preview-cool showcase screenshot
```

- [ ] **Step 3: Add the install target**

After the `herdr:` target's `HERDR_INSTALL_SCRIPT` `endef`/`export` block (i.e. just before the `# VSCode:` comment), add:

```make
# herdr-app (desktop): theme files are standalone JSON in themes/, so this is a
# plain file install; the app's theme picker picks them up automatically.
herdr-app:
	mkdir -p $(HERDR_APP_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)herdr-app/figure5-warm-charcoal.json $(HERDR_APP_THEMES_DIR)/figure5-warm-charcoal.json
	$(INSTALL) $(SRC_PREFIX)herdr-app/figure5-softer-warm.json $(HERDR_APP_THEMES_DIR)/figure5-softer-warm.json
	$(INSTALL) $(SRC_PREFIX)herdr-app/figure5-cool.json $(HERDR_APP_THEMES_DIR)/figure5-cool.json
```

- [ ] **Step 4: Add the uninstall target**

After `uninstall-herdr`'s `HERDR_UNINSTALL_SCRIPT` `endef`/`export` block (just before `uninstall-vscode:`), add:

```make
uninstall-herdr-app:
	rm -f $(HERDR_APP_THEMES_DIR)/figure5-warm-charcoal.json
	rm -f $(HERDR_APP_THEMES_DIR)/figure5-softer-warm.json
	rm -f $(HERDR_APP_THEMES_DIR)/figure5-cool.json
```

- [ ] **Step 5: Verify Makefile syntax and target wiring**

Run: `make -n herdr-app`
Expected: three `ln -sf` (or `cp` with `INSTALL_METHOD=copy`) lines targeting `~/.config/herdr-app/themes/`.

Run: `make -n uninstall-herdr-app`
Expected: three `rm -f` lines.

- [ ] **Step 6: Commit**

```bash
/usr/bin/git add Makefile
/usr/bin/git commit -m "Add make herdr-app install target"
```

---

### Task 3: Docs (README + CLAUDE.md)

**Files:**
- Modify: `README.md` — add a `### Herdr (desktop app)` section after the Claude Code section (before `### Rex`), and add `herdr-app/` handling wherever files are listed.
- Modify: `CLAUDE.md` — update the Herdr status-table row and add a usage section.

**Interfaces:**
- Consumes: the install target from Task 2.
- Produces: user-facing install/usage instructions.

- [ ] **Step 1: Add README section**

Insert after the Claude Code section (which ends before `### Rex`):

```markdown
### Herdr (desktop app)

Run `make herdr-app` to install, or copy the `.json` files to `~/.config/herdr-app/themes/`.
The themes then appear in Herdr's theme picker (`app.theme` / Settings) alongside the
built-ins — pick "figure5-warm-charcoal", "figure5-softer-warm", or "figure5-cool".

This targets the Herdr **desktop app** (`Herdr.app`); the Herdr *terminal server* is
covered separately under [Herdr](#herdr) below.
```

Note: check while editing whether a `### Herdr` (terminal server) section exists in README; it currently does not — if adding one is trivial (copy the usage block from CLAUDE.md's "Herdr Usage"), add it too so the anchor resolves; otherwise drop the cross-reference sentence.

- [ ] **Step 2: Update CLAUDE.md**

In the status table, add a row after the Herdr row:

```markdown
| Herdr (app)   | Done           | `herdr-app/figure5-{warm-charcoal,softer-warm,cool}.json` |
```

After the existing "## Herdr Usage" section, add:

```markdown
## Herdr (Desktop App) Usage

Run `make herdr-app` to install, or copy the `.json` files to `~/.config/herdr-app/themes/`.
The desktop app's theme picker (`app.theme` / Settings) lists them automatically — pick
"figure5-warm-charcoal", "figure5-softer-warm", or "figure5-cool".

The desktop app is a separate target from the Herdr terminal server above: its themes are
standalone JSON files (`background`/`foreground`/`selection`/`cursor`, a 16-colour `ansi`
array, and a `colors` map overriding the app-chrome palette), not `[theme]` sections in
`config.toml`. The terminal layer is copied verbatim from the matching Ghostty files; the
UI layer steps surfaces up from each variant's background, uses gold `#E0CC1A` as
`accent`/`solid`, and follows the Claude Code status-colour rule (working=amber,
blocked=red, done=yellow-green).
```

- [ ] **Step 3: Commit**

```bash
/usr/bin/git add README.md CLAUDE.md
/usr/bin/git commit -m "Document herdr-app theme install and usage"
```

---

### Task 4: End-to-end install check

**Files:** none created; runs `make herdr-app` against the real config dir.

- [ ] **Step 1: Install and verify files land**

Run: `make herdr-app && ls ~/.config/herdr-app/themes/`
Expected: `figure5-warm-charcoal.json`, `figure5-softer-warm.json`, `figure5-cool.json` present alongside `atom-one-dark.json` and `win98.json`.

- [ ] **Step 2: Report**

Tell the user to open Herdr's theme picker and confirm the three "figure5-*" themes appear and render correctly. Visual confirmation is the user's (colour perception is the whole point of this repo).
