#! /usr/bin/env python3

import argparse
import os
import sys
import stat

g_lang_codes = {
	"c": "cs",
	"e": "en",
	"f": "fr",
	"d": "de",
}

l_lang_codes = {
	"e": "Anglicko",
	"f": "Francouzsko",
	"d": "Nemecko",
}


langs = g_lang_codes.keys()

template_transl="""#! /usr/bin/env bash

set -e -o pipefail


if [ $# -eq 0 ]; then
	s=`basename $0`
	echo "usage: $s phrase"
	exit 1
fi

q=`echo "$*" | sed 's/ /\+/g'`
"""

def chmodx(fn):
	st = os.stat(fn)
	os.chmod(fn, st.st_mode | stat.S_IEXEC)


def gtrans(fn,fr,to):
	with open(fn,"w") as f:
		f.write('{te}\nopen "https://translate.google.com/#{fr}/{to}/$q"'.format(
			te=template_transl,
			fr=g_lang_codes[fr],
			to=g_lang_codes[to],
		))
	chmodx(fn)

def ltrans(fn,fr):
	with open(fn,"w") as f:
		f.write('{te}\nopen "https://slovniky.lingea.cz/{fr}-{to}/$q"'.format(
			te=template_transl,
			fr=l_lang_codes[fr],
			to="cesky",
		))
	chmodx(fn)

for fr in langs:
	for to in langs:
		if fr==to:
			continue
		gtrans("g.{}{}".format(fr,to),fr,to)
		if to=="c":
			ltrans("l.{}{}".format(fr,"c"),fr)
			ltrans("l.{}{}".format("c",fr),fr)


