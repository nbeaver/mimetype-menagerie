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

mimetypes_in_repo = {}

for dirpath, dirnames, filenames in os.walk('media-types/'):
    if filenames:
        # If there are files, we know we are in a directory with examples,
        # so we add the media type to the list.
        temp, subtype = os.path.split(dirpath)
        _, media_type = os.path.split(temp)
        if media_type not in mimetypes_in_repo:
            mimetypes_in_repo[media_type] = set([subtype])
        else:
            mimetypes_in_repo[media_type].add(subtype)

total_iana = 0
total_in_common = 0
total_to_do = 0
total_unregistered = 0
for media_type, subtypes_iana in mimetypes_iana.items():
    total_iana += len(subtypes_iana)
    if media_type in mimetypes_in_repo:
        subtypes_in_repo = mimetypes_in_repo[media_type]
    else:
        subtypes_in_repo = set()
    subtypes_in_common = set.intersection(subtypes_iana, subtypes_in_repo)
    total_in_common += len(subtypes_in_common)
    percent_in_common = 100*len(subtypes_in_common)/len(subtypes_iana)
    subtypes_unregistered = subtypes_in_repo - subtypes_iana
    total_unregistered += len(subtypes_unregistered)
    subtypes_to_do = subtypes_iana - subtypes_in_repo
    total_to_do += len(subtypes_to_do)
    percent_to_do = 100*len(subtypes_to_do)/len(subtypes_iana)
    print(media_type)
    print("    IANA mimetypes in repo: {:>4} ({:>6.2f}%)".format(len(subtypes_in_common), percent_in_common) )
    print("    IANA mimetypes missing: {:>4} ({:>6.2f}%)".format(len(subtypes_to_do), percent_to_do) )
    print("    In repo, but not IANA: {:>5}".format(len(subtypes_unregistered)) )

total_percent_in_common = 100*total_in_common/total_iana
total_percent_to_do = 100*total_to_do/total_iana
print("Total IANA mimetypes in repo: {:>4} ({:>6.2f}%)".format(total_in_common, total_percent_in_common) )
print("Total IANA mimetypes missing: {:>4} ({:>6.2f}%)".format(total_to_do, total_percent_to_do) )
print("Total in repo, but not IANA: {:>5}".format(total_unregistered) )
