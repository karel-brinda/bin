.PHONY: all help clean cleanall

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

FROM_SUF=from
TO_SUF=to

FROM=$(wildcard *.$(FROM_SUF))
TO=$(patsubst %.$(FROM_SUF),%.$(TO_SUF),$(FROM))

$(info From: $(FROM))
$(info To:   $(TO))

all: $(TO)

%.$(TO_SUF): %.$(FROM_SUF)
	touch $@

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean

cleanall: clean ## Clean all


