GHOSTTY_THEMES_DIR := $(HOME)/.config/ghostty/themes
ZED_THEMES_DIR     := $(HOME)/.config/zed/themes
HELIX_THEMES_DIR   := $(HOME)/.config/helix/themes
K9S_SKINS_DIR      := $(HOME)/.config/k9s/skins

.PHONY: all ghostty zed helix k9s \
        uninstall-ghostty uninstall-zed uninstall-helix uninstall-k9s \
        preview preview-cool showcase screenshot

all: ghostty zed helix k9s

ghostty:
	mkdir -p $(GHOSTTY_THEMES_DIR)
	cp ghostty/figure5-warm-charcoal $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	cp ghostty/figure5-softer-warm $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	cp ghostty/figure5-cool $(GHOSTTY_THEMES_DIR)/figure5-cool

zed:
	mkdir -p $(ZED_THEMES_DIR)
	cp zed/figure5.json $(ZED_THEMES_DIR)/figure5.json

helix:
	mkdir -p $(HELIX_THEMES_DIR)
	cp helix/figure5-warm-charcoal.toml $(HELIX_THEMES_DIR)/figure5-warm-charcoal.toml
	cp helix/figure5-softer-warm.toml $(HELIX_THEMES_DIR)/figure5-softer-warm.toml
	cp helix/figure5-cool.toml $(HELIX_THEMES_DIR)/figure5-cool.toml

k9s:
	mkdir -p $(K9S_SKINS_DIR)
	cp k9s/figure5-warm-charcoal.yaml $(K9S_SKINS_DIR)/figure5-warm-charcoal.yaml
	cp k9s/figure5-softer-warm.yaml $(K9S_SKINS_DIR)/figure5-softer-warm.yaml
	cp k9s/figure5-cool.yaml $(K9S_SKINS_DIR)/figure5-cool.yaml

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
