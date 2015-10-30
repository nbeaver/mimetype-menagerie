#! /usr/bin/env python3

import csv
import glob
import collections

registered_mimetypes = collections.OrderedDict()

for filename in glob.glob("iana/*.csv"):
    with open(filename) as csvfile:
        media_type = filename.rstrip('.csv')
        # e.g. registered_mimetypes['application'] = []
        registered_mimetypes[media_type] = []
        reader = csv.DictReader(csvfile)
        for row in reader:
            subtype = row['Name']
            registered_mimetypes[media_type].append(subtype)

for media_type, subtypes in registered_mimetypes.items():
    print(media_type, len(subtypes))
