#! /usr/bin/env python3

from __future__ import print_function
import os
import sys

if len(sys.argv) > 1:
    rootdir = sys.argv[1]
else:
    sys.stderr.write("Usage: {} media-types/\n".format(sys.argv[0]))
    sys.exit(1)

for dirpath, dirnames, filenames in os.walk(rootdir):
    if filenames:
        # If there are files, we know we are in a directory with examples,
        # so we add the media type to the list.
        temp, subtype = os.path.split(dirpath)
        _, media_type = os.path.split(temp)
        print(media_type + '/' + subtype)
