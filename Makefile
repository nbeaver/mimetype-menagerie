.PHONY : validate-local
validate-local : check-mimetypes.out readme.html todo.html

.PHONY : validate-remote
validate-remote: check-urls.out

check-mimetypes.out : check-mimetypes.py media-types/ Makefile
	python3 check-mimetypes.py media-types/ > check-mimetypes.out

check-urls.out : check-urls.py urls.json Makefile
	python3 check-urls.py urls.json > check-urls.out

readme.html : readme.rst Makefile
	rst2html readme.rst readme.html

todo.html : todo.md Makefile
	markdown todo.md > todo.html
