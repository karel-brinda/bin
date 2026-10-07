.PHONY: all clean view
.SILENT: all


SHELL=/usr/bin/env bash -eo pipefail

MAIN = main
FIGURES := $(shell find figures -name "*.pdf" -type f 2>/dev/null)
SOURCES := $(MAIN).tex $(shell find . -name "*.tex" -type f)


all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCES) $(FIGURES)
	latexmk -synctex=1 -pdflatex=lualatex -pdf $(MAIN)


view:
	(open $(MAIN).pdf \
	|| acroread $(MAIN).pdf \
	|| evince $(MAIN).pdf) 2> /dev/null > /dev/null &


clean:
	latexmk -C $(MAIN)
