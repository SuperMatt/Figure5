# Figure 5 theme for Herdr (desktop app) — Design

Date: 2026-11-02
Status: approved (variant scope confirmed by user)

## Goal

Add Figure 5 themes for **herdr-app** — the Herdr desktop app (`Herdr.app`,
binary `~/.local/bin/herdr-app`, config `~/.config/herdr-app/`). This is a
separate target from the Herdr *terminal server* already covered by
`herdr/figure5-*.toml`; the two apps share a name but not a theme format.

## Theme format (from the app's own docs: `~/.config/herdr-app/AGENTS.md`, `herdr.d.ts`)

Files live in `~/.config/herdr-app/themes/<name>.json`; the in-app theme
picker lists them automatically. Schema:

```json
{
  "background": "#rrggbb",   // terminal background
  "foreground": "#rrggbb",
  "selection": "#rrggbb",
  "cursor": "#rrggbb",       // optional
  "ansi": [16 hex colors],   // 0-7 dark, 8-15 bright, standard ANSI order
  "colors": { ... }          // optional UI-chrome overrides; panel colors are derived if absent
}
```

Documented `colors` keys (`herdr.d.ts` `theme()`): `background`, `foreground`,
`surface`, `canvas`, `chrome`, `popover`, `raised`, `hover`, `selected`,
`border`, `input`, `muted`, `dim`, `accent`, `accent_foreground`, `solid`,
`solid_foreground`, `selection`, `working`, `blocked`, `done`, `idle`,
`unknown`. (`background`/`foreground` inside `colors` are the UI's, distinct
from the terminal's — see the shipped `win98.json`.)

## Deliverables

1. `herdr-app/figure5-warm-charcoal.json`, `figure5-softer-warm.json`,
   `figure5-cool.json` — all three variants, per repo convention.
2. Makefile: `herdr-app` target (install to `~/.config/herdr-app/themes/`,
   honouring `INSTALL_METHOD`), `uninstall-herdr-app`, added to `all` and the
   `.PHONY` list.
3. README.md usage section + CLAUDE.md status-table row.

## Colour mapping

**Terminal layer:** `ansi[16]`, `background`, `foreground`, `cursor`,
`selection` copied verbatim from the matching `ghostty/` files (the two warm
variants share one ANSI palette; only the background differs).

**UI chrome layer (`colors`):**

- Surfaces stepped from each variant's background, reusing tones already
  chosen elsewhere in the repo:
  - warm variants: `chrome` `#151210` < `background` (#1E1B19 / #252220) <
    `canvas` `#252220` < `surface`/`raised` `#2A2623` < `popover`/`hover`
    `#35302C` < `border` `#3D3732`; `input` `#151210` (sunken field).
  - cool variant: neutral grey steps around `#1C1C1C`:
    `chrome` `#141414`, `canvas` `#202020`, `surface`/`raised` `#242424`,
    `popover`/`hover` `#2C2C2C`, `border` `#383838`, `input` `#141414`.
- `accent` / `solid` = gold `#E0CC1A`; `accent_foreground` / `solid_foreground`
  = the variant's background (dark text on gold).
- Status colours follow the Claude Code theme rule (red means danger only):
  `working` `#FFD420`, `blocked` `#CC2211`, `done` `#6CB200`,
  `idle`/`unknown` = bright black `#8A6448` (warm) / cool grey `#77828C` (cool).
- `selected`/`selection` = `#5C1A1A` (the palette selection crimson).
- `muted` = subtext tone (`#CDBA90` warm / `#C4CED8` cool); `dim` = bright
  black `#8A6448` (warm) / `#77828C` (cool).
- `colors.background`/`colors.foreground` = the variant's background and
  foreground, stated explicitly.

## Verification

- `python3 -m json.tool` parses each file; shape compared against the shipped
  `atom-one-dark.json` / `win98.json` examples.
- After `make herdr-app`, the three themes appear in Herdr's theme picker
  (manual visual check by the user; app hot-loads `themes/`).

## Out of scope

- No changes to the existing `herdr/` terminal-server themes.
- No app-side settings changes (layout `theme` fields, `settings.json`) — the
  theme picker is the selection mechanism.
