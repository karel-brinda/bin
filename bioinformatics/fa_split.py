#! /usr/bin/env python3

import argparse
import os
import sys
from Bio import SeqIO


def split_fa(fa_fn):
    for seq_record in SeqIO.parse(fa_fn, "fasta"):
        with open("{}.fa".format(seq_record.id), "w+") as f:
            f.write(">{}\n".format(seq_record.id))
            f.write("{}\n".format(seq_record.seq))


def main():
    parser = argparse.ArgumentParser(description="")

    parser.add_argument(
        'fa',
        type=str,
        metavar='file.fa',
        help='',
    )

    args = parser.parse_args()

    split_fa(args.fa)


if __name__ == "__main__":
    main()
