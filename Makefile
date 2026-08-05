GHOSTTY_THEMES_DIR := $(HOME)/.config/ghostty/themes
ZED_THEMES_DIR     := $(HOME)/.config/zed/themes
HELIX_THEMES_DIR   := $(HOME)/.config/helix/themes
K9S_SKINS_DIR      := $(HOME)/.config/k9s/skins
ZELLIJ_THEMES_DIR  := $(HOME)/.config/zellij/themes
FRESH_THEMES_DIR   := $(HOME)/.config/fresh/themes
CLAUDE_THEMES_DIR  := $(HOME)/.claude/themes
HERDR_CONFIG       := $(HOME)/.config/herdr/config.toml
VSCODE_EXT_DIR     := $(HOME)/.vscode/extensions/figure5-theme-1.0.0
CURSOR_EXT_DIR     := $(HOME)/.cursor/extensions/figure5-theme-1.0.0

# Installation method: 'symlink' (default) or 'copy'
INSTALL_METHOD ?= symlink

ifeq ($(INSTALL_METHOD),symlink)
INSTALL    = ln -sf
SRC_PREFIX = $(CURDIR)/
else
INSTALL    = cp
SRC_PREFIX =
endif

.PHONY: all ghostty zed helix k9s zellij fresh claude herdr vscode cursor \
        uninstall-ghostty uninstall-zed uninstall-helix uninstall-k9s \
        uninstall-zellij uninstall-fresh uninstall-claude uninstall-herdr \
        uninstall-vscode uninstall-cursor \
        preview preview-cool showcase screenshot

all: ghostty zed helix k9s zellij fresh claude herdr vscode cursor

ghostty:
	mkdir -p $(GHOSTTY_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)ghostty/figure5-warm-charcoal $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	$(INSTALL) $(SRC_PREFIX)ghostty/figure5-softer-warm $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	$(INSTALL) $(SRC_PREFIX)ghostty/figure5-cool $(GHOSTTY_THEMES_DIR)/figure5-cool

zed:
	mkdir -p $(ZED_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)zed/figure5.json $(ZED_THEMES_DIR)/figure5.json

helix:
	mkdir -p $(HELIX_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)helix/figure5-warm-charcoal.toml $(HELIX_THEMES_DIR)/figure5-warm-charcoal.toml
	$(INSTALL) $(SRC_PREFIX)helix/figure5-softer-warm.toml $(HELIX_THEMES_DIR)/figure5-softer-warm.toml
	$(INSTALL) $(SRC_PREFIX)helix/figure5-cool.toml $(HELIX_THEMES_DIR)/figure5-cool.toml

k9s:
	mkdir -p $(K9S_SKINS_DIR)
	$(INSTALL) $(SRC_PREFIX)k9s/figure5-warm-charcoal.yaml $(K9S_SKINS_DIR)/figure5-warm-charcoal.yaml
	$(INSTALL) $(SRC_PREFIX)k9s/figure5-softer-warm.yaml $(K9S_SKINS_DIR)/figure5-softer-warm.yaml
	$(INSTALL) $(SRC_PREFIX)k9s/figure5-cool.yaml $(K9S_SKINS_DIR)/figure5-cool.yaml

# Zellij: installs UI theme to ~/.config/zellij/themes/
# The web client theme (figure5-web.kdl) must be pasted into config.kdl manually.
zellij:
	mkdir -p $(ZELLIJ_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)zellij/figure5.kdl $(ZELLIJ_THEMES_DIR)/figure5.kdl

# Fresh: installs theme JSON files to ~/.config/fresh/themes/
fresh:
	mkdir -p $(FRESH_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)fresh/figure5-warm-charcoal.json $(FRESH_THEMES_DIR)/figure5-warm-charcoal.json
	$(INSTALL) $(SRC_PREFIX)fresh/figure5-softer-warm.json $(FRESH_THEMES_DIR)/figure5-softer-warm.json
	$(INSTALL) $(SRC_PREFIX)fresh/figure5-cool.json $(FRESH_THEMES_DIR)/figure5-cool.json

# Claude Code: installs custom themes to ~/.claude/themes/
# Select with /theme (stored as custom:figure5-warm-charcoal, etc.)
claude:
	mkdir -p $(CLAUDE_THEMES_DIR)
	$(INSTALL) $(SRC_PREFIX)claude/figure5-warm-charcoal.json $(CLAUDE_THEMES_DIR)/figure5-warm-charcoal.json
	$(INSTALL) $(SRC_PREFIX)claude/figure5-softer-warm.json $(CLAUDE_THEMES_DIR)/figure5-softer-warm.json
	$(INSTALL) $(SRC_PREFIX)claude/figure5-cool.json $(CLAUDE_THEMES_DIR)/figure5-cool.json

# Herdr: writes theme config. Since herdr uses inline [theme] in config.toml (no
# standalone theme files), this target replaces any existing [theme] block.
# Defaults to warm-charcoal; pass HERDR_VARIANT=softer-warm or HERDR_VARIANT=cool.
HERDR_VARIANT ?= warm-charcoal
herdr:
	@mkdir -p $(dir $(HERDR_CONFIG))
	@python3 -c "$$HERDR_INSTALL_SCRIPT"
	@echo "Applied figure5-$(HERDR_VARIANT) to $(HERDR_CONFIG)"
	@echo "Run 'herdr server reload-config' to apply."

define HERDR_INSTALL_SCRIPT
import os, re
theme_src = open('herdr/figure5-$(HERDR_VARIANT).toml').read()
lines = [l for l in theme_src.splitlines() if not l.startswith('#')]
theme_block = '\n'.join(lines).strip() + '\n'
cfg_path = '$(HERDR_CONFIG)'
cfg = open(cfg_path).read() if os.path.exists(cfg_path) else ''
cfg = re.sub(r'\n?\[theme[\].].*?(?=\n\[(?!theme)|\Z)', '', cfg, flags=re.DOTALL).rstrip()
cfg = cfg + '\n\n' + theme_block if cfg else theme_block
open(cfg_path, 'w').write(cfg)
endef
export HERDR_INSTALL_SCRIPT

# VSCode: installs as a local extension (no symlink support — always copies)
vscode:
	mkdir -p $(VSCODE_EXT_DIR)/themes
	cp vscode/package.json $(VSCODE_EXT_DIR)/package.json
	cp vscode/themes/figure5-color-theme.json $(VSCODE_EXT_DIR)/themes/figure5-color-theme.json
	cp vscode/themes/figure5-softer-warm-color-theme.json $(VSCODE_EXT_DIR)/themes/figure5-softer-warm-color-theme.json
	cp vscode/themes/figure5-cool-color-theme.json $(VSCODE_EXT_DIR)/themes/figure5-cool-color-theme.json

# Cursor: same extension format, different extensions dir
cursor:
	mkdir -p $(CURSOR_EXT_DIR)/themes
	cp vscode/package.json $(CURSOR_EXT_DIR)/package.json
	cp vscode/themes/figure5-color-theme.json $(CURSOR_EXT_DIR)/themes/figure5-color-theme.json
	cp vscode/themes/figure5-softer-warm-color-theme.json $(CURSOR_EXT_DIR)/themes/figure5-softer-warm-color-theme.json
	cp vscode/themes/figure5-cool-color-theme.json $(CURSOR_EXT_DIR)/themes/figure5-cool-color-theme.json

uninstall-ghostty:
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-cool

uninstall-zed:
	rm -f $(ZED_THEMES_DIR)/figure5.json

uninstall-helix:
	rm -f $(HELIX_THEMES_DIR)/figure5-warm-charcoal.toml
	rm -f $(HELIX_THEMES_DIR)/figure5-softer-warm.toml
	rm -f $(HELIX_THEMES_DIR)/figure5-cool.toml

uninstall-k9s:
	rm -f $(K9S_SKINS_DIR)/figure5-warm-charcoal.yaml
	rm -f $(K9S_SKINS_DIR)/figure5-softer-warm.yaml
	rm -f $(K9S_SKINS_DIR)/figure5-cool.yaml

uninstall-zellij:
	rm -f $(ZELLIJ_THEMES_DIR)/figure5.kdl

uninstall-fresh:
	rm -f $(FRESH_THEMES_DIR)/figure5-warm-charcoal.json
	rm -f $(FRESH_THEMES_DIR)/figure5-softer-warm.json
	rm -f $(FRESH_THEMES_DIR)/figure5-cool.json

uninstall-claude:
	rm -f $(CLAUDE_THEMES_DIR)/figure5-warm-charcoal.json
	rm -f $(CLAUDE_THEMES_DIR)/figure5-softer-warm.json
	rm -f $(CLAUDE_THEMES_DIR)/figure5-cool.json

uninstall-herdr:
	@python3 -c "$$HERDR_UNINSTALL_SCRIPT"
	@echo "Removed [theme] section from $(HERDR_CONFIG)"
	@echo "Run 'herdr server reload-config' to apply."

define HERDR_UNINSTALL_SCRIPT
import re
cfg_path = '$(HERDR_CONFIG)'
cfg = open(cfg_path).read()
cfg = re.sub(r'\n?\[theme[\].].*?(?=\n\[(?!theme)|\Z)', '', cfg, flags=re.DOTALL).rstrip() + '\n'
open(cfg_path, 'w').write(cfg)
endef
export HERDR_UNINSTALL_SCRIPT

uninstall-vscode:
	rm -rf $(VSCODE_EXT_DIR)

uninstall-cursor:
	rm -rf $(CURSOR_EXT_DIR)

preview:
	bash preview.sh warm

preview-cool:
	bash preview.sh cool

showcase:
	bash showcase.sh warm

showcase-softer:
	bash showcase.sh softer

showcase-cool:
	bash showcase.sh cool

screenshot:
	@echo "Requires: ghostty themes installed (make ghostty) + gnome-screenshot (GNOME), grim (Sway/Hyprland), or scrot (X11)"
	bash screenshot-themes.sh
