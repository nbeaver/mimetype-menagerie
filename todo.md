----------------
Mimetypes to add
----------------

- archive formats
  - [x] `.zip`
  - [x] `.tar.gz`
  - [ ] `.iso`
  - [ ] [DAISY e-book files](https://bugs.freedesktop.org/show_bug.cgi?id=91873)
- `text/plain` formats
  - [ ] trashinfo files (MS config files).
  - [ ] fstab file
  - [ ] debian `.dsc` files
- `text/calendar`
  - [ ] iCal files (.ics)
- [ ] `text/x-apt-sources-list` (sources.list file for debian)
  - [ ] https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-controlsyntax
- [ ] `.xm` files for trackers
- [x] `.rtf` files
- [ ] `.csv` files with semicolon delimiters and commas as decimal marks.

----------
Validation
----------

- [x] Check for broken URLs.
- [x] Check that each file is in the folder corresponding to its mimetype.
- [ ] List of SHA1 checksums to avoid re-downloading.
