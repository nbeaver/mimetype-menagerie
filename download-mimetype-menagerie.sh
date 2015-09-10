#!/usr/bin/env bash

# Criteria for files, in order of priority:
# -- Reliable URIs.
# -- Relatively small size to save bandwidth.
# -- Public domain or Creative Commons licensing.

# TODO: figure out how to check if they've already been download,
# maybe with md5sum or CRC checksum?
# Or checking if the date is more recent?
# Or use zsync or something?

# DONE: move the URLS to a text file.

# TODO: convert this to python so that it is more portable.

function download {
	# Use --location so that it will resolve 302 errors,
	# and use --remote-name so that we can just use the URI.
	curl --location --remote-name "$*"
}

function download_list {
    while read line
    do
        if [[ "$line" != "\#*" ]] # ignore comments
        then
            download "$line"
        fi
    done < "$*"
}

# Documents.
mkdir --parents documents/
cd documents/
download_list ./document-URIs.txt
cd -

# Images.
mkdir --parents images/
cd images/
download_list ./image-URIs.txt
cd -

# Audio.
mkdir --parents audio/
cd audio/
download_list ./audio-URIs.txt
cd -

# Video.
mkdir --parents video/
cd video/
download_list ./video-URIs.txt
cd -

# Code.
mkdir --parents code/
cd code/
touch Makefile
touch file.c
touch file.cpp
touch file.sh
touch file.python

touch file.js
touch file.css
touch file.java
touch file.tex
cd -

# XAFS stuff.
mkdir --parents xafs/
cd xafs/
download_list ./data-URIs.txt
cd -
