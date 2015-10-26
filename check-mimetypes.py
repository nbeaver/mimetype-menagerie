#! /usr/bin/env python3

import mimetypes
import os
import warnings

rootdir = 'media-types'
for dirpath, dirnames, filenames in os.walk(rootdir):
    for filename in filenames:
        temp, expected_subtype = os.path.split(dirpath)
        _, expected_toplevel = os.path.split(temp)
        expected_mimetype = "/".join([expected_toplevel, expected_subtype])
        compound_mimetype, encoding = mimetypes.guess_type(filename)
        full_path = os.path.join(dirpath, filename)
        if compound_mimetype:
            toplevel, subtype = compound_mimetype.split('/')
            if compound_mimetype != expected_mimetype:
                print("Expected", repr(expected_mimetype), "but got", repr(compound_mimetype), "for " + full_path)
