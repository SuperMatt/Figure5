# SuperTheme — "Figure 5"

A unified terminal/editor colour theme inspired by Charles Demuth's 1928 painting
*I Saw the Figure 5 in Gold*, itself a response to William Carlos Williams' poem
*The Great Figure*. Designed for a red/green colour-blind user whose favourite colour
is red.

## Status

| Application   | Status         | Files                                              |
|---------------|----------------|----------------------------------------------------|
| Ghostty       | Done           | `ghostty/figure5-warm-charcoal`, `ghostty/figure5-softer-warm`, `ghostty/figure5-cool` |
| Zed           | Done           | `zed/figure5.json`                                 |
| VSCode/Cursor | Not started    |                                                    |
| Helix         | Done           | `helix/figure5-{warm-charcoal,softer-warm,cool}.toml` |
| k9s           | Done           | `k9s/figure5-{warm-charcoal,softer-warm,cool}.yaml`   |

## Ghostty Usage

Copy the theme file to `~/.config/ghostty/themes/`, then set in `~/.config/ghostty/config`:

```
theme = figure5-warm-charcoal
# or
theme = figure5-softer-warm
# or
theme = figure5-cool
```

Three variants exist — two warm, one cool. Pick whichever feels better at your screen brightness.

## Helix Usage

Run `make helix` to install, or copy the `.toml` files to `~/.config/helix/themes/`. Then set in `~/.config/helix/config.toml`:

```toml
theme = "figure5-warm-charcoal"
# or: figure5-softer-warm, figure5-cool
```

## k9s Usage

Run `make k9s` to install, or copy the `.yaml` files to `~/.config/k9s/skins/`. Then set in `~/.config/k9s/config.yaml`:

```yaml
k9s:
  ui:
    skin: figure5-warm-charcoal
```

## Slack Usage

No installable file — Slack sidebar themes are applied in-app. Open:
**Preferences > Themes > Custom Theme** and paste a colour string from `slack/figure5.txt`.

## Zed Usage

Run `make zed` to install, or copy `zed/figure5.json` to `~/.config/zed/themes/` manually. Then set in `~/.config/zed/settings.json`:

```json
"theme": "Figure 5 – Warm Charcoal"
// or
"theme": "Figure 5 – Softer Warm"
// or
"theme": "Figure 5 – Cool"
```

Or open the theme picker (`Ctrl+K Ctrl+T`) and search for "Figure 5".

## Palette

| Role                       | Hex       | RGB            |
|----------------------------|-----------|----------------|
| Background (warm charcoal) | `#1E1B19` | 30, 27, 25     |
| Background (softer warm)   | `#252220` | 37, 34, 32     |
| Background (cool)          | `#1C1C1C` | 28, 28, 28     |
| Foreground (warm variants) | `#F0E0B8` | 240, 224, 184  |
| Foreground (cool variant)  | `#D8DDE4` | 216, 221, 228  |
| Cursor (warm)              | `#FAF0D0` | 250, 240, 208  |
| Cursor (cool)              | `#E0EAF0` | 224, 234, 240  |
| Selection                  | `#401818` | 64, 24, 24     |
| Black                      | `#1C0A0C` | 28, 10, 12     |
| Bright Black               | `#8A6448` | 138, 100, 72   |
| Red                        | `#CC2211` | 204, 34, 17    |
| Bright Red                 | `#FF3322` | 255, 51, 34    |
| Green                      | `#6CB200` | 108, 178, 0    |
| Bright Green               | `#8ED400` | 142, 212, 0    |
| Yellow                     | `#E0961A` | 224, 150, 26   |
| Bright Yellow              | `#FFB820` | 255, 184, 32   |
| Blue                       | `#4878C8` | 72, 120, 200   |
| Bright Blue                | `#5080D0` | 80, 128, 208   |
| Magenta                    | `#B84078` | 184, 64, 120   |
| Bright Magenta             | `#C04880` | 192, 72, 128   |
| Cyan                       | `#5A90A0` | 90, 144, 160   |
| Bright Cyan                | `#68A8B8` | 104, 168, 184  |
| White (warm variants)      | `#CDBA90` | 205, 186, 144  |
| Bright White (warm)        | `#FAF0D0` | 250, 240, 208  |
| White (cool variant)       | `#C4CED8` | 196, 206, 216  |
| Bright White (cool)        | `#E0EAF0` | 224, 234, 240  |

## Design Decisions

### Inspiration
The painting uses deep crimson fields, ivory geometric arcs, and a bold gold numeral
against near-black. That maps naturally onto a dark terminal theme: crimson background,
parchment foreground, amber/gold as the accent, and red as the hero colour.

### Background
The original crimson-black background (`#2C1014`) was rejected after seeing the theme
full-screen — the red cast felt wrong at scale. Four grey candidates were evaluated
interactively:

- `#1E1B19` **warm charcoal** — very dark, faint warmth, closest to charcoal ✓
- `#1C1C1E` neutral grey — rejected, read as too blue/cold
- `#181B20` cool grey — rejected, read as too blue
- `#252220` **softer warm** — slightly lighter, the warmest of the greys ✓

A third cool variant was later added. Several blue-grey backgrounds were evaluated;
all were rejected as too blue. A pure neutral `#1C1C1C` was chosen instead, paired
with cool blue-grey whites (`#C4CED8` / `#E0EAF0`) to give a cooler feel without
a coloured cast in the background itself.

### Foreground
The warm variants use `#F0E0B8` — warm parchment/ivory, taken from the painting's
white arcs. Avoids the harshness of pure white while maintaining strong contrast.

The cool variant uses `#D8DDE4` — a cool blue-grey white that pairs with the neutral
background and cool whites. Several options were evaluated; cooler foregrounds were
rejected as too blue, warmer ones looked inconsistent against the cool whites.

### Cursor (`#FAF0D0` / `#E0EAF0`)
Changed from the original red (`#CC2211`) to bright white. White gives maximum
contrast against any background colour and is instantly visible regardless of
what colour the text beneath it is.

### Red (`#CC2211` / `#FF3322`)
Kept close to the painting's crimson. Vivid and saturated so it stays legible as
an accent even for a colour-blind viewer (who sees red as brownish — high saturation
helps it remain distinct from other warm tones by luminance alone).

### Green (`#6CB200` / `#8ED400`)
The trickiest colour for a red-green colour-blind user. Pure greens are indistinguishable
from reds for deuteranopes. These greens sit at ~85° hue (yellow-green), which is
distinguishable from red by both hue angle and luminance. They were initially too far
toward yellow/gold and iterated toward more genuine green while keeping them off pure
spectral green.

### Yellow (`#E0961A` / `#FFB820`)
Directly from the painting's gold numeral. Amber rather than lemon yellow, warm and
rich. This is the "hero" accent colour of the palette alongside red.

### Blue (`#3060A8` / `#5080D0`)
A cool counterpoint to the warm reds and golds. Taken from the cool atmospheric depth
in the painting's background. Kept deliberately distinct in hue from cyan so both
colours remain useful.

### Magenta (`#A03060` / `#C04880`)
A pink-red with strong blue content. The blue component ensures it doesn't blur with
red for a colour-blind viewer — it reads as clearly purple-pink rather than red-adjacent.

### Bright Black (`#8A6448`)
Used for comments and dim UI elements. Was initially `#402018` (too dark, unreadable
against the background). Lightened to a warm earthy brown that reads as clearly muted
without disappearing.

### White / Bright White (`#CDBA90` / `#FAF0D0`)
Warm tans rather than neutral greys, keeping the palette tonally consistent. True
neutral greys would feel cold and disconnected from the rest of the palette. Bumped
slightly from the initial values (`#C0A880` / `#F5E8C0`) which were a touch too dim.

## Preview Script

`preview.sh` — run with `bash preview.sh warm` or `bash preview.sh cool` (or `make preview` / `make preview-cool`) to see palette swatches and a syntax sample for either variant family.

## Notes for Future Apps

- Comment colours should be set explicitly in editor configs rather than relying on
  ANSI Bright Black — this gives more control per-application.
- k9s: map green→success, red→error, yellow→warning, cyan→info.
- The palette was designed and iterated interactively in Ghostty with true-colour
  ANSI previews, so the hex values reflect what actually looked good on screen.
