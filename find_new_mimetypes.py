#! /usr/bin/env python3

from __future__ import print_function
import os
import sys
import mimetypes
import argparse
import logging

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

def get_unknown_mimetypes(
        known,
        narrow_top_level=None,
        suppress_repeats=True
    ):

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
                logging.debug("mimetype is 'None' for file '{}'".format(filepath))
                continue
            elif mimetype in known:
                # Mimetype is already known, so skip to next file.
                logging.debug("already known mimetype '{}' for file '{}'".format(mimetype, filepath))
                continue
            elif narrow_top_level is not None:
                # We are only interested in e.g. 'audio' mimetypes.
                if top_level != narrow_top_level:
                    logging.debug("mimetype '{}' for file '{}' does not match top-level '{}'".format(mimetype, filepath, narrow_top_level))
                    # No match, so skip this one.
                    continue
            elif mimetype in new_mimetypes and suppress_repeats:
                # Mimetype was previously encountered, so skip to next.
                logging.debug("suppressing already found mimetype '{}' from file '{}'".format(mimetype, filepath))
                continue

            # Might as well add the mimetype now.
            new_mimetypes.add(mimetype)

            yield mimetype, filepath

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
    parser.add_argument('-s', '--suppress-repeats',
        help='Suppress printing of duplicate mimetypes',
        action='store_true',
        default=False,
    )
    parser.add_argument(
        '-v',
        '--verbose',
        help='More verbose logging',
        dest="loglevel",
        default=logging.WARNING,
        action="store_const",
        const=logging.INFO,
    )
    parser.add_argument(
        '-d',
        '--debug',
        help='Enable debugging logs',
        action="store_const",
        dest="loglevel",
        const=logging.DEBUG,
    )
    args = parser.parse_args()
    logging.basicConfig(level=args.loglevel)

    known_mimetypes = get_known_mimetypes(args.known_mimetypes_file)

    for mimetype, filepath in get_unknown_mimetypes(known=known_mimetypes, narrow_top_level=args.toplevel, suppress_repeats=args.suppress_repeats):
        sys.stdout.write('{}\t{}\n'.format(mimetype, filepath))
        sys.stdout.flush()
