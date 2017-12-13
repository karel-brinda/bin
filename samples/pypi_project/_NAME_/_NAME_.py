#! /usr/bin/env python3

"""_NAME_

Author:  Karel Brinda <kbrinda@hsph.harvard.edu>

License: MIT
"""

import argparse
import os
import re
import sys

sys.path.append(os.path.dirname(__file__))
import version

PROGRAM='_NAME_'
VERSION=version.VERSION
DESC=''

def parse_args():

    parser = CustomArgumentParser (
            formatter_class=argparse.RawTextHelpFormatter,
            description=
            "Program: {} ({})\n".format(PROGRAM, DESC)+
            "Version: {}\n".format(VERSION, pysam.__version__) +
            "Author:  Karel Brinda <kbrinda@hsph.harvard.edu>",
            )
    parser.add_argument('-v', '--version',
            action='version',
            version='{} {} (using pysam {})'.format(PROGRAM, VERSION, pysam.__version__),
            )

    args = parser.parse_args()

    return args


def main ():
    args=parse_args()
    print("Hello")


if __name__ == "__main__":
    main()
