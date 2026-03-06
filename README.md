# Figure 5

A dark terminal and editor colour theme inspired by Charles Demuth's 1928 painting
*I Saw the Figure 5 in Gold*. Designed with red/green colour blindness in mind —
greens are shifted to yellow-green (~85° hue) to stay distinguishable from red.

Three variants are provided — two warm, one cool:

| Variant | Background | Character |
|---|---|---|
| `figure5-warm-charcoal` | `#1E1B19` | Very dark, faint warm undertone |
| `figure5-softer-warm` | `#252220` | Slightly lighter, warmest of the three |
| `figure5-cool` | `#1C1C1C` | Pure neutral grey, cool blue-grey whites |

## Palette

The warm and cool variants share all accent colours. Only the background and whites differ.

### Shared

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

### Per-variant

| Role | Warm variants | Cool variant |
|---|---|---|
| White | `#CDBA90` | `#C4CED8` |
| Bright White | `#FAF0D0` | `#E0EAF0` |

## Preview

```sh
make preview       # warm variants
make preview-cool  # cool variant
```

## Installation

### Ghostty

```sh
make ghostty
```

Then set in `~/.config/ghostty/config`:

```
theme = figure5-warm-charcoal
# or: figure5-softer-warm, figure5-cool
```
