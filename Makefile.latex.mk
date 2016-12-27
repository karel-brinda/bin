.PHONY: all clean mendeley m view main.pdf
.SILENT: all


SHELL:=/bin/bash -o pipefail

MAIN = main
FIGURES := $(shell find figures -name "*.pdf" -type f)
SOURCES := $(MAIN).tex $(shell find . -name "*.tex" -type f)


all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCES) $(FIGURES)
	latexmk -pdf $(MAIN)

mendeley:
	#perl -pe 's@,\n@,NEWLINE@g' | \

	cat ~/Documents/library.bib | \
		grep -v '^abstract =' | \
		grep -v '^keywords =' | \
		grep -v '^editor =' | \
		grep -v '^month =' | \
		grep -v 'booktitle = {bioR' | \
		grep -v '^lang =' | \
		grep -v '^issn =' | \
		grep -v '^language =' | \
		grep -v '^isbn =' | \
		grep -v '^file =' | \
		sed 's/\ (Oxford,\ England)//g' | \
		perl -pe 's@url = \{http://arxiv@journal = \{arXiv preprints\},\nurl = \{http://arxiv@g' | \
		perl -pe 's@doi = \{10.1101/0@journal = \{bioRxiv preprints\},\ndoi = \{10.1101/0@g' | \
		perl -pe 's/^@/PAPER@/g' | \
		perl -pe 's@\n@NEWLINE@g' | \
		perl -pe 's/PAPER@/\nPAPER@/g' | \
		grep 'PAPER@' | \
		sort | \
		perl -pe 's/PAPER@/@/g' | \
		sed '/biorxiv/s/@techreport/@article/g' | \
		perl -pe 's@NEWLINE@\n@g' | \
		tee > /tmp/mendeley.bib
	
	cp /tmp/mendeley.bib mendeley.bib
	
	cat mendeley.bib | \
		sed 's/{\\_}/\\_/g' | \
		awk '!(/url/ && !(/arxiv/ || /biorxiv/ || /peerj/))' | \
		tee > mendeley_filtered.bib
	#cat additional_references.bib >> mendeley_filtered.bib

view:
	(open $(MAIN).pdf \
	|| acroread $(MAIN).pdf \
	|| evince $(MAIN).pdf) 2> /dev/null > /dev/null &


clean:
	latexmk -c
