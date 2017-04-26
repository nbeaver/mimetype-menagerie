.PHONY : validate-local
validate-local : warnings.txt readme.html todo.html known_mimetypes.txt coverage_report.txt

.PHONY : validate-remote
validate-remote: url_check.py urls.json
	./url_check.py urls.json

warnings.txt : check-mimetypes.py media-types/*/*
	python3 check-mimetypes.py media-types/ > warnings.txt

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
	rm --force warnings.txt todo.html readme.html coverage_report.txt
