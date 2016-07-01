#! /usr/bin/env python3

import mimetypes
import os
import sys
import subprocess
import shutil

def walkdir(rootdir):
    for dirpath, dirnames, filenames in os.walk(rootdir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            temp, expected_subtype = os.path.split(dirpath)
            _, expected_toplevel = os.path.split(temp)
            expected_mimetype = "/".join([expected_toplevel, expected_subtype])
            guesses = {}
            python_mimetype, encoding = mimetypes.guess_type(filename)
            guesses['python.mimetypes.guess_type()'] = python_mimetype
            if shutil.which('mimetype'):
                perl_mimetype = subprocess.check_output(['mimetype', '--brief', filepath]).decode().strip()
                guesses['mimetype(1)'] = perl_mimetype
            if shutil.which('file'):
                file_mimetype = subprocess.check_output(['file', '--brief', '--mime-type', filepath]).decode().strip()
                guesses['file(1)'] = file_mimetype
            check_match(expected_mimetype, guesses, filepath)


def check_match(expected, guesses, path):
    for guesser, guess in guesses.items():
        if guess and guess != expected:
            print("Warning: expected {} but got {} from {} on file {}".format(repr(expected), repr(guess), repr(guesser), repr(path)))

if len(sys.argv) > 1:
    walkdir(sys.argv[1])
else:
    sys.stderr.write("Usage: {} media-types/\n".format(sys.argv[0]))
    sys.exit(1)
