#! /usr/bin/env python3

import json
import urllib.request

mimetype_dict = json.load(open('urls.json'))

for _, subtype_dict in mimetype_dict.items():
    for _, url_list in subtype_dict.items():
        for url in url_list:
            # TODO: check urls in parallel?
            try:
                f = urllib.request.urlopen(url)
            except urllib.error.HTTPError as err:
                # TODO: url may redirect to err.url; display this too?
                print("URL failed with status {}: {}".format(err.code, url))
