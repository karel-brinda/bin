#! /usr/bin/env python3

import argparse
import collections
import os
import re
import sys


def remove_homopolymers(seq, quals=None):
    """ Take sequences and remove homopolymers (e.g., CAAAAAG -> CAG).
    """
    last_nucl=None
    oseq=[]
    oqual=[]
    if quals is None or quals=='':
        for nucl in seq:
            if nucl!=last_nucl:
                oseq.append(nucl)
                last_nucl=nucl
        return "".join(oseq), None
    else:
        zipped=zip(seq, quals)
        for nucl,qual in zipped:
            if nucl!=last_nucl:
                oseq.append(nucl)
                oqual.append(qual)
                last_nucl=nucl
        return "".join(oseq), "".join(oqual)


def readfq(fp):
    """FASTA/FASTQ reader. Based on https://github.com/lh3/readfq.
    """
    last = None
    while True:
        if not last:
            for l in fp:
                if l[0] in '>@':
                    last = l[:-1]
                    break
        if not last:
            break
        name, _, comment  = last[1:].partition(" ")
        seqs, last = [], None
        for l in fp:
            if l[0] in '@+>':
                last = l[:-1]
                break
            seqs.append(l[:-1])
        if not last or last[0] != '+':
            yield name, comment, ''.join(seqs), None
            if not last:
                break
        else:
            seq, leng, seqs = ''.join(seqs), 0, []
            for l in fp:
                seqs.append(l[:-1])
                leng += len(l) - 1
                if leng >= len(seq):
                    last = None
                    yield name, comment, seq, ''.join(seqs)
                    break
            if last:
                yield name, comment, seq, None
                break


def remove_homopolymers_from_file(infile, ofile):
    for name, comment, seq, qual in readfq(infile):
        seq_wo_hpolys, quals_wo_hpolys=remove_homopolymers(seq, qual)
        if comment=='':
            pseudoname=name
        else:
            pseudoname="{} {}".format(name, comment)
        if qual:
            ofile.write("@{}\n{}\n+{}\n{}\n".format(pseudoname, seq_wo_hpolys, "", quals_wo_hpolys))
        else:
            ofile.write(">{}\n{}\n".format(pseudoname, seq_wo_hpolys))


def main():
    parser = argparse.ArgumentParser(description="")

    parser.add_argument('ifile',
            type=argparse.FileType('r'),
            metavar='in.file',
            help='Input file',
        )

    parser.add_argument('ofile',
            type=argparse.FileType('w'),
            metavar='out.file',
            help='Output file',
        )

    args = parser.parse_args()

    remove_homopolymers_from_file(args.ifile, args.ofile)


if __name__ == "__main__":
    main()
