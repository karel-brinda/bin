rule all:
    input: [f"{k}.fa" for k in range (2, 31)]

rule:
    output: "{k}.fa"
    input: []
    shell:
        """
            touch "{output}"
        """

rule clean:
    shell:
        """
        rm -f *.fai
        """

rule cleanall:
    shell:
        """
        rm -f *.fa *.fai
        """

