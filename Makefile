GHOSTTY_THEMES_DIR := $(HOME)/.config/ghostty/themes

.PHONY: all ghostty uninstall-ghostty preview preview-cool

all: ghostty

ghostty:
	mkdir -p $(GHOSTTY_THEMES_DIR)
	cp ghostty/figure5-warm-charcoal $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	cp ghostty/figure5-softer-warm $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	cp ghostty/figure5-cool $(GHOSTTY_THEMES_DIR)/figure5-cool

uninstall-ghostty:
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-warm-charcoal
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-softer-warm
	rm -f $(GHOSTTY_THEMES_DIR)/figure5-cool

preview:
	bash preview.sh warm

preview-cool:
	bash preview.sh cool
