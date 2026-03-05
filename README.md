# Figure 5

A dark terminal and editor colour theme inspired by Charles Demuth's 1928 painting
*I Saw the Figure 5 in Gold*. Designed with red/green colour blindness in mind —
greens are shifted to yellow-green (~85° hue) to stay distinguishable from red.

Two background variants are provided. Pick whichever suits your screen and lighting:

| Variant | Background |
|---|---|
| `figure5-warm-charcoal` | `#1E1B19` — darker, more austere |
| `figure5-softer-warm` | `#252220` — slightly lighter, warmer |

## Palette

| Role | Hex |
|---|---|
| Foreground | `#F0E0B8` |
| Cursor | `#CC2211` |
| Selection | `#401818` |
| Black / Bright Black | `#1C0A0C` / `#8A6448` |
| Red / Bright Red | `#CC2211` / `#FF3322` |
| Green / Bright Green | `#5A9400` / `#7AC400` |
| Yellow / Bright Yellow | `#E0961A` / `#FFB820` |
| Blue / Bright Blue | `#3060A8` / `#5080D0` |
| Magenta / Bright Magenta | `#A03060` / `#C04880` |
| Cyan / Bright Cyan | `#487888` / `#68A8B8` |
| White / Bright White | `#CDBA90` / `#FAF0D0` |

## Installation

### Ghostty

```sh
make ghostty
```

Then set in `~/.config/ghostty/config`:

```
theme = figure5-warm-charcoal
```
