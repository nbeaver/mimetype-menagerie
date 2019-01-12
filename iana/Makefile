WGET_FLAGS :=--execute robots=off --recursive --level=2 --no-parent --no-directories --accept '*.csv'
URL :='https://www.iana.org/assignments/media-types/'

download-quiet :
	wget $(WGET_FLAGS) --quiet $(URL)

download-no-verbose :
	wget $(WGET_FLAGS) --no-verbose $(URL)

CSV :=$(wildcard *.csv)
clean :
	rm -f -- $(CSV)
