#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes


try:
    rootdir = sys.argv[1]
    mimepath = sys.argv[2]
except IndexError:
    sys.stderr.write("Usage: {} /path/of/interest known-mimetypes.txt\n".format(sys.argv[0]))
    sys.exit(1)

known_mimetypes = set()
with open(mimepath) as mimefile:
    for line in mimefile.readlines():
        known_mimetypes.add(line.strip())

unknown_mimetypes = set()
for dirpath, dirnames, filenames in os.walk(rootdir):
    for filename in filenames:
        mimetype, encoding = mimetypes.guess_type(filename)
        if mimetype and mimetype not in known_mimetypes:
            unknown_mimetypes.add(mimetype)

for mimetype in sorted(unknown_mimetypes):
    print(mimetype)

