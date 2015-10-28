----------------
Mimetypes to add
----------------

- `application`
  - [x] `.rtf` files
  - archive formats
    - [x] `.zip`
    - [x] `.tar.gz`
    - [ ] `.iso`
    - [ ] [DAISY e-book files](https://bugs.freedesktop.org/show_bug.cgi?id=91873)
- `audio`
  - [ ] `audio/x-xm` (`.xm` files for trackers)
- `text`
  - `text/plain` formats
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
  - [ ] `text/x-apt-sources-list` (sources.list file for debian)
    - https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-controlsyntax

----------
Validation
----------

- [x] Check for broken URLs.
- [x] Check that each file is in the folder corresponding to its mimetype.
- [ ] List of SHA1 checksums to avoid re-downloading.
