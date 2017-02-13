#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes

if __name__ == '__main__':
    try:
        mimepath = sys.argv[1]
        rootdir = sys.argv[2]
    except IndexError:
        sys.stderr.write("Usage: {} known-mimetypes.txt /path/of/interest\n".format(sys.argv[0]))
        sys.exit(1)

    known_mimetypes = set()
    with open(mimepath) as mimefile:
        for line in mimefile.readlines():
            known_mimetypes.add(line.strip())

    new_mimetypes = {}
    for dirpath, dirnames, filenames in os.walk(rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            mimetype, encoding = mimetypes.guess_type(filename)
            if mimetype and mimetype not in known_mimetypes:
                if mimetype not in new_mimetypes:
                    new_mimetypes[mimetype] = []
                new_mimetypes[mimetype].append(filepath)

    for mimetype in sorted(new_mimetypes.keys()):
        for path in new_mimetypes[mimetype]:
            print(mimetype, path)
