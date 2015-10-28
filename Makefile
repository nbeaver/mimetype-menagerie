.PHONY : validate-local
validate-local : check-mimetypes.py.out check-mimetypes.sh.out readme.html todo.html

.PHONY : validate-remote
validate-remote: check-urls.py.out

check-mimetypes.py.out : check-mimetypes.py media-types/ Makefile
	python3 check-mimetypes.py media-types/ > check-mimetypes.py.out

check-mimetypes.sh.out : check-mimetypes.sh media-types/ Makefile
	bash check-mimetypes.sh > check-mimetypes.sh.out

check-urls.py.out : check-urls.py urls.json Makefile
	python3 check-urls.py urls.json > check-urls.py.out

readme.html : readme.rst Makefile
	rst2html readme.rst readme.html

todo.html : todo.md Makefile
	markdown todo.md > todo.html
