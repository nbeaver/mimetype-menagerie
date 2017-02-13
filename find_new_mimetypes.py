#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes
import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='For discovering mimetypes not already in the mimetype menagerie')
    parser.add_argument('known_mimetypes_filepath', type=argparse.FileType('r'), help='Path to text file with list of known mimetypes.')
    parser.add_argument('rootdir', help='Root directory to start looking for new mimetypes.')
    args = parser.parse_args()
    if not os.path.isdir(args.rootdir):
        sys.stderr.write("Error: not a directory: {}\n".format(args.rootdir))
        sys.exit(1)

    known_mimetypes = set()
    with args.known_mimetypes_filepath as mimefile:
        for line in mimefile.readlines():
            known_mimetypes.add(line.strip())

    new_mimetypes = set()
    for dirpath, dirnames, filenames in os.walk(args.rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            mimetype, encoding = mimetypes.guess_type(filename)
            if mimetype is not None and mimetype not in known_mimetypes and mimetype not in new_mimetypes:
                new_mimetypes.add(mimetype)
                sys.stdout.write('{}\t{}\n'.format(mimetype, filepath))
                sys.stdout.flush()
