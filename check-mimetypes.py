#! /usr/bin/env python3

import mimetypes
import os
import sys
import subprocess
import shutil

def walkdir(rootdir):
    filepaths = []
    for dirpath, dirnames, filenames in os.walk(rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            filepaths.append(filepath)
            python_mimetype, encoding = mimetypes.guess_type(filename)
            if python_mimetype != None:
                check_match(expected_mimetype(filepath), python_mimetype, 'python.mimetypes.guess_type()', filepath)

    def run_subprocess(cmd, args, name, delimiter):
        if shutil.which(cmd):
            output = subprocess.check_output([cmd] + args + filepaths).decode()
            lines = output.split('\n')
            for line in lines:
                if delimiter in line:
                    filepath, mimetype = line.split(sep=delimiter, maxsplit=1)
                    mimetype = mimetype.strip()
                    check_match(expected_mimetype(filepath), mimetype, name, filepath)

    run_subprocess('mimetype', ['--noalign'], 'mimetype(1)', ':')
    run_subprocess('file', ['--mime-type'], 'file(1)', ':')

def expected_mimetype(filepath):
    parent, _ = os.path.split(filepath)
    grandparent, subtype = os.path.split(parent)
    _, toplevel = os.path.split(grandparent)
    return "/".join([toplevel, subtype])

def check_match(expected, guess, guesser, path):
    if guess != expected:
        print("Warning: expected {} but got {} from {} on file {}".format(repr(expected), repr(guess), repr(guesser), repr(path)))

if len(sys.argv) > 1:
    walkdir(sys.argv[1])
else:
    sys.stderr.write("Usage: {} media-types/\n".format(sys.argv[0]))
    sys.exit(1)
