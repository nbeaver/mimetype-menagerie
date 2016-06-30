#! /usr/bin/env python3

import json
import urllib.request
import sys

if len(sys.argv) > 1:
    mimetype_dict = json.load(open(sys.argv[1]))
else:
    print("Usage: {} urls.json".format(sys.argv[0]))
    sys.exit(1)

for _, subtype_dict in mimetype_dict.items():
    for _, url_list in subtype_dict.items():
        for url in url_list:
            # TODO: check urls in parallel
            f = None
            try:
                f = urllib.request.urlopen(url)
            except urllib.error.HTTPError as err:
                # TODO: url may redirect to err.url; display this too?
                print("URL failed with status {}: {}".format(err.code, url))
                raise
            except urllib.error.URLError as err:
                print("URL failed : {}".format(url))
                raise
            except ConnectionResetError as err:
                print("Connection failed on: {}".format(err.code, url))
                raise
