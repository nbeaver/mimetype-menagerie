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

def get_unknown_mimetypes(known, narrow_top_level=None, print_on_the_fly=False):
    new_mimetypes = set()
    for dirpath, dirnames, filenames in os.walk(args.rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            # TODO: measure size in bytes like this:
            # size_bytes = os.stat(filepath).st_size
            # then only show duplicate files if they are smaller.
            mimetype, encoding = mimetypes.guess_type(filename)

            if mimetype:
                top_level, subtype = mimetype.split('/')
            else:
                top_level, subtype = None, None

            if mimetype is None:
                # Mimetype could not be determined, so try next file.
                continue
            elif mimetype in known_mimetypes:
                # Mimetype is already known, so skip to next file.
                continue
            elif mimetype in new_mimetypes:
                # Mimetype was previously encountered, so skip to next file.
                # TODO: make this behavior optional
                continue
            elif narrow_top_level:
                if top_level != narrow_top_level:
                    continue

            new_mimetypes.add(mimetype)
            if print_on_the_fly:
                # TODO: use yield instead
                sys.stdout.write('{}\t{}\n'.format(mimetype, filepath))
                sys.stdout.flush()

    return new_mimetypes

top_level_types = [
    'application',
    'audio',
    'chemical',
    'drawing',
    'example',
    'font',
    'image',
    'inode',
    'message',
    'model',
    'multipart',
    'text',
    'video'
]

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
    parser.add_argument('-t', '--toplevel',
        help='Restrict to one top level type',
        choices=top_level_types
    )

    args = parser.parse_args()

    known_mimetypes = get_known_mimetypes(args.known_mimetypes_file)

    get_unknown_mimetypes(known_mimetypes, args.toplevel, print_on_the_fly=True)
