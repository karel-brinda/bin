#! /usr/bin/env python3

import argparse
import os
import re
import sys

REOP=re.compile(r'(\d+)([X=]{1})')

def cigar_to_bitmask(cigar):
    matches = REOP.findall(cigar)
    bm=[]
    for ln,op in matches:
        bm.extend(int(ln)*[op=="="])
    return bm

def mask_mismatches(seq, bit_mask):
    assert len(seq)==len(bit_mask)
    newseq=[]
    for n,b in zip(seq, bit_mask):
        if b:
            newseq.append(n)
        else:
            newseq.append('N')
    return "".join(newseq)


def clean_sam_line(l):
    parts=l.split("\t")
    seq,cigar=parts[9],parts[5]
    bm=cigar_to_bitmask(cigar)
    newseq=mask_mismatches(seq, bm)
    parts[9]=newseq
    return "\t".join(parts)


def process_sam(sam):
    for l in sam:
        if len(l)==0:
            continue
        elif l[0]=="@":
            print(l,end="")
        elif l.find("ii:i:1\t")!=-1:
            print(clean_sam_line(l),end="")


def main():
    parser = argparse.ArgumentParser(description="Clean")

    parser.add_argument('sam',
        metavar='file.sam',
        help="SAM file (to use BAM, use samtools and '-')",
        type=argparse.FileType('r')
    )

    args = parser.parse_args()
    process_sam(args.sam)

if __name__ == "__main__":
    main()
