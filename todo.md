----------------
Mimetypes to add
----------------

- `application`
  - [x] [`application/rtf`](media-types/application/rtf/) Rich Text Format (`.rtf`)
  - [x] [`application/zip`](media-types/application/zip/) Zip file (`.zip`)
  - [x] [`application/x-compressed-tar`](media-types/application/x-compressed-tar/) Gzipped tar file (`.tar.gz`)
  - [ ] [DAISY e-book files](https://bugs.freedesktop.org/show_bug.cgi?id=91873)
  - [ ] `application/x-iso9660-image` ISO disk image (`.iso`)
    - Hard to find files of reasonable size.
- `audio`
  - [ ] `audio/x-xm` (`.xm` files for trackers)
- `text`
  - [`text/plain`](media-types/text/plain/)
    - [ ] INI files (MS config files).
    - [ ] fstab file
    - [ ] debian `.dsc` files
  - `text/calendar`
    - [ ] iCal files (.ics)
  - `text/csv`
    - [ ] [RFC 4180](https://tools.ietf.org/html/rfc4180) compliant files.
    - [ ] `.csv` files that are entirely numeric
    - [ ] `.csv` files with quoting
    - [ ] `.csv` files with semicolon delimiters and commas as decimal marks.
  - [ ] `text/x-apt-sources-list` (sources.list file for Debian)
    - https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-controlsyntax

----------
Validation
----------

- [x] Check for broken URLs.
- [x] Check that each file is in the folder corresponding to its mimetype.
- [ ] List of SHA1 checksums to avoid re-downloading.
