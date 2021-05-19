shell.prefix("set -euo pipefail")

rule all:
    input:
    output:
    shell:
        """
            echo Hello
        """
