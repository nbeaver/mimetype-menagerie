.PHONY : validate
validate : check-mimetypes.out check-uris.out readme.html

check-mimetypes.out : check-mimetypes.py media-types/ Makefile
	python3 check-mimetypes.py > check-mimetypes.out

check-uris.out : check-uris.py uri-list.json Makefile
	python3 check-uris.py > check-uris.out

readme.html : readme.rst Makefile
	rst2html readme.rst readme.html
