#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes


if len(sys.argv) > 1:
    rootdir = sys.argv[1]
else:
    sys.stderr.write("Usage: {} media-types/\n".format(sys.argv[0]))
    sys.exit(1)

known_mimetypes = set()
for dirpath, dirnames, filenames in os.walk(rootdir):
    for filename in filenames:
        mimetype, encoding = mimetypes.guess_type(filename)
        if mimetype != None:
            known_mimetypes.add(mimetype)

for mimetype in sorted(known_mimetypes):
    print(mimetype)
