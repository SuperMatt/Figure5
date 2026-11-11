# Figure 5 for rex-rune (`rex-linux`)

[rex-rune](https://github.com/shuv1337/rex-rune) is the native Linux Rex client. It has two
separate theme layers:

## 1. Terminal theme — no patch needed

rex-rune reads Ghostty theme files from `~/.config/ghostty/themes`. Run `make ghostty` (or
copy `ghostty/figure5-cool` there), then pick **figure5-cool** in Settings → Terminal → Theme,
or set in `~/.config/rex-linux/workspace.json`:

```json
"terminal_theme": "named:figure5-cool",
"terminal_theme_chosen": true
```

## 2. Chrome palette — `figure5-cool.patch`

The interface palette (sidebar, toolbar, tabs, popovers) is compiled in: only Midnight,
Rosé Pine, Rosé Pine Moon and Gruvbox Dark exist. `figure5-cool.patch` (against `v0.5.2`)
adds a **Figure 5 – Cool** chrome palette plus its paired built-in terminal theme
(`rex/figure5-cool`), so choosing the palette also sets matching terminal colours.

```bash
git clone --branch v0.5.2 https://github.com/shuv1337/rex-rune.git
cd rex-rune
git apply /path/to/figure5/rex-rune/figure5-cool.patch
cargo test && cargo build --release
```

Then choose Settings → Interface → Theme → **Figure 5 – Cool**
(`"chrome_theme": "figure5_cool"` in `workspace.json`).

| Token                | Value     | Role                                        |
|----------------------|-----------|---------------------------------------------|
| `ground` / `card`    | `#1C1C1C` | cool variant background                     |
| `popover`            | `#2C2C2C` | raised surfaces (matches herdr-app popover) |
| `ink`                | `#D8DDE4` | cool foreground                             |
| `muted`              | `#8A96A0` | cool grey, 5.6:1 on ground                  |
| `accent`             | `#E0CC1A` | gold, "the figure 5 in gold"                |
| `accent2`            | `#5080D0` | bright blue                                 |
| `live`               | `#6CB200` | success, yellow-green                       |
| `warning`            | `#E0961A` | amber (~38°, 33° clear of danger)           |
| `danger`             | `#FF3322` | bright red, used only for danger            |
| `on_accent`          | `#1C1C1C` | text on gold buttons                        |
| `terminal_selection` | `#5C1A1A` | crimson selection                           |

The values pass rex-rune's own palette test (muted/ink ≥ 4.5:1, warning/danger ≥ 3:1 on
both surfaces, warning and danger ≥ 30° apart in hue).
