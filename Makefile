GHOSTTY_THEMES_DIR := $(HOME)/.config/ghostty/themes
ZED_THEMES_DIR     := $(HOME)/.config/zed/themes

.PHONY: all ghostty zed uninstall-ghostty uninstall-zed preview preview-cool

all: ghostty zed

ghostty:
	mkdir -p $(GHOSTTY_THEMES_DIR)
	cp ghostty/figure5-warm-charcoal $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	cp ghostty/figure5-softer-warm $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	cp ghostty/figure5-cool $(GHOSTTY_THEMES_DIR)/figure5-cool

zed:
	mkdir -p $(ZED_THEMES_DIR)
	cp zed/figure5.json $(ZED_THEMES_DIR)/figure5.json

uninstall-ghostty:
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-cool

uninstall-zed:
	rm -f $(ZED_THEMES_DIR)/figure5.json

preview:
	bash preview.sh warm

preview-cool:
	bash preview.sh cool
