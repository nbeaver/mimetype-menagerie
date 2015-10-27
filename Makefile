all : check-mimetypes.out check-uris.out

check-mimetypes.out : check-mimetypes.py media-types/
	python3 check-mimetypes.py > check-mimetypes.out

check-uris.out : check-uris.py uri-list.json
	python3 check-uris.py > check-uris.out
