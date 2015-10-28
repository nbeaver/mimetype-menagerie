----------------
Mimetypes to add
----------------

- [ ] zip formats
  - [x] `.zip`
  - [x] `.tar.gz`
  - [ ] `.iso`
- [ ] trashinfo files (MS config files).
- [ ] iCal files (.ics)
- [ ] sources.list file (for debian)
- [ ] fstab file
- [ ] debian `.dsc` files
  - [ ] https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-controlsyntax
- [ ] `.xm` files for trackers
- [x] `.rtf` files
- [ ] `.csv` files with semicolon delimiters and commas as decimal marks.
- [ ] DAISY e-book files separately from zip files (https://bugs.freedesktop.org/show_bug.cgi?id=91873)

----------
Validation
----------

- [x] Check for broken URLs.
- [x] Check that each file is in the folder corresponding to its mimetype.
- [ ] List of SHA1 checksums to avoid re-downloading.
