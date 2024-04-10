.PHONY: all help clean cleanall cluster

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

all: ## Run everything
	snakemake -j --printshellcmds

cluster: ## Submit jobs to a cluster
	snakemake --cores 9999 --printshellcmds --keep-going \
		--cluster-config cluster.json \
		--cluster 'sbatch -p {cluster.queue} -c {cluster.n} -t {cluster.time} --mem={cluster.memory}'

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean
	snakemake clean

cleanall: ## Cleanall
cleanall: clean
	snakemake cleanall

