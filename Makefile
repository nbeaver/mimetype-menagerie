.PHONY : validate
validate : check-mimetypes.out check-urls.out readme.html

check-mimetypes.out : check-mimetypes.py media-types/ Makefile
	python3 check-mimetypes.py media-types/ > check-mimetypes.out

check-urls.out : check-urls.py urls.json Makefile
	python3 check-urls.py urls.json > check-urls.out

readme.html : readme.rst Makefile
	rst2html readme.rst readme.html
