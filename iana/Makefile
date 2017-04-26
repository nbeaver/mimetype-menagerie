CSV := application.csv audio.csv font.csv image.csv message.csv model.csv multipart.csv text.csv video.csv
DOWNLOAD := wget --no-verbose

all : $(CSV)

application.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/application.csv'

audio.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/audio.csv'

font.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/font.csv'

image.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/image.csv'

message.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/message.csv'

model.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/model.csv'

multipart.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/multipart.csv'

text.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/text.csv'

video.csv :
	$(DOWNLOAD) 'http://www.iana.org/assignments/media-types/video.csv'

clean :
	rm -f $(CSV)
