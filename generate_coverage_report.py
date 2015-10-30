#! /usr/bin/env python3

import csv
import glob
import collections
import os

mimetypes_iana = collections.OrderedDict()

for path in glob.glob("iana/*.csv"):
    with open(path) as csvfile:
        # This is a bit of a hack,
        # but it works since the filenames match the media type.
        media_type = os.path.basename(path).rstrip('.csv')
        # e.g. mimetypes_iana['application'] = []
        mimetypes_iana[media_type] = set()
        reader = csv.DictReader(csvfile)
        for row in reader:
            subtype = row['Name']
            mimetypes_iana[media_type].add(subtype)

print('Mimetypes registered:')
for media_type, subtypes in mimetypes_iana.items():
    print(media_type, len(subtypes))

mimetypes_in_repo = {}

for dirpath, dirnames, filenames in os.walk('media-types/'):
    for filename in filenames:
        temp, subtype = os.path.split(dirpath)
        _, media_type = os.path.split(temp)
        if media_type not in mimetypes_in_repo:
            mimetypes_in_repo[media_type] = set()
        else:
            mimetypes_in_repo[media_type].add(subtype)

print('Mimetypes in repo:')
for media_type, subtypes in mimetypes_in_repo.items():
    print(media_type, len(subtypes))
