.PHONY : validate
validate : check-mimetypes.out check-uris.out

check-mimetypes.out : Makefile check-mimetypes.py media-types/
	python3 check-mimetypes.py > check-mimetypes.out

check-uris.out : Makefile check-uris.py uri-list.json
	python3 check-uris.py > check-uris.out
