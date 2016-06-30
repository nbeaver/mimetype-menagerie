#! /usr/bin/env python3

import mimetypes
import os
import sys
import subprocess

def walkdir(rootdir):
    for dirpath, dirnames, filenames in os.walk(rootdir):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)
            temp, expected_subtype = os.path.split(dirpath)
            _, expected_toplevel = os.path.split(temp)
            expected_mimetype = "/".join([expected_toplevel, expected_subtype])
            guesses = {}
            python_mimetype, encoding = mimetypes.guess_type(filename)
            guesses['python.mimetypes.guess_type()'] = python_mimetype
            if os.path.isfile('mimetype'):
                perl_mimetype = subprocess.call(['mimetype', '--brief', filename])
                guesses['mimetype(1)'] = perl_mimetype
            if os.path.isfile('file'):
                file_mimetype = subprocess.call(['file', '--brief', '--mime-type', filename])
                guesses['file(1)'] = file_mimetype
            check_match(expected_mimetype, guesses, full_path)


def check_match(expected, guesses, path):
    for guesser, guess in guesses.items():
        if guess and guess != expected:
            print("Warning: expected {} but got {} for {} at file {}".format(repr(expected), repr(guess), repr(guesser), repr(path)))

walkdir(sys.argv[1])
