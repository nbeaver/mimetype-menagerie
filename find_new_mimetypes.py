#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes
import argparse

def readable_directory(path):
    if not os.path.isdir(path):
        raise argparse.ArgumentTypeError('not an existing directory: {}'.format(path))
    if not os.access(path, os.R_OK):
        raise argparse.ArgumentTypeError('not a readable directory: {}'.format(path))
    return path

def get_known_mimetypes(mimetypes_fp):
    mimetypes = set()
    for line in mimetypes_fp.readlines():
        mimetypes.add(line.strip())
    return mimetypes

def print_unknown_mimetypes(known):
    new_mimetypes = set()
    for dirpath, dirnames, filenames in os.walk(args.rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            mimetype, encoding = mimetypes.guess_type(filename)
            if mimetype is not None and mimetype not in known_mimetypes and mimetype not in new_mimetypes:
                new_mimetypes.add(mimetype)
                sys.stdout.write('{}\t{}\n'.format(mimetype, filepath))
                sys.stdout.flush()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='For discovering mimetypes not already in the mimetype menagerie'
    )
    parser.add_argument('known_mimetypes_file',
        type=argparse.FileType('r'),
        help='Path to text file with list of known mimetypes.'
    )
    parser.add_argument('rootdir',
        type=readable_directory,
        help='Root directory to start looking for new mimetypes.'
    )

    args = parser.parse_args()

    known_mimetypes = get_known_mimetypes(args.known_mimetypes_file)

    print_unknown_mimetypes(known_mimetypes)
