#! /usr/bin/env bash

if test $# -lt 1
then
    echo "Usage: bash check-mimetypes.sh media-types/"
    exit 1
fi

for toplevel in "$*"/*;
do
    for subtype in "$toplevel"/*;
    do
        for file in "$subtype"/*;
        do
            if test -f "$file"
            then
                expected_folder="media-types/$(mimetype --brief $file)\n"
                actual_folder="media-types/$(mimetype --brief $file)\n"
                if test "$expected_folder" != "$actual_folder"
                then
                    printf -- "Warning: $file should be in $expected_folder\n"
                fi
            fi
        done
    done
done
