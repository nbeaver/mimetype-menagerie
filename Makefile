.PHONY : validate-local
validate-local : check-mimetypes.py.out readme.html todo.html known_mimetypes.txt coverage_report.txt

.PHONY : validate-remote
validate-remote: check-urls.py urls.json
	python3 check-urls.py urls.json

check-mimetypes.py.out : check-mimetypes.py media-types/*/*
	python3 check-mimetypes.py media-types/ > check-mimetypes.py.out

readme.html : readme.rst
	rst2html readme.rst readme.html

todo.html : todo.md
	markdown todo.md > todo.html

known_mimetypes.txt : media-types/*/* known_mimetypes.py
	python3 known_mimetypes.py media-types/ > known_mimetypes.txt

coverage_report.txt : generate_coverage_report.py media-types/*/* iana/*.csv
	python3 generate_coverage_report.py > coverage_report.txt

.PHONY : clean
clean:
	rm --force check-mimetypes.py.out
	rm --force check-urls.py.out
	rm --force todo.html
	rm --force readme.html
	rm --force coverage_report.txt
