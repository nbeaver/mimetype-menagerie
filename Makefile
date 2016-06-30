.PHONY : validate-local
validate-local : check-mimetypes.py.out readme.html todo.html coverage_report.txt

.PHONY : validate-remote
validate-remote: check-urls.py urls.json
	python3 check-urls.py urls.json

check-mimetypes.py.out : check-mimetypes.py media-types/*/* Makefile
	python3 check-mimetypes.py media-types/ > check-mimetypes.py.out

readme.html : readme.rst Makefile
	rst2html readme.rst readme.html

todo.html : todo.md Makefile
	markdown todo.md > todo.html

coverage_report.txt : generate_coverage_report.py Makefile media-types/*/* iana/*.csv
	python3 generate_coverage_report.py > coverage_report.txt

.PHONY : clean
clean:
	rm --force check-mimetypes.py.out
	rm --force check-urls.py.out
	rm --force todo.html
	rm --force readme.html
	rm --force coverage_report.txt
