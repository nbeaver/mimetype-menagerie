#!/usr/bin/env bash

# Criteria for files:
# -- Reliable URIs.
# -- Relatively small size to save bandwidth.
# -- Public domain or Creative Commons licensing.

function download {
	# Use --location so that it will resolve 302 errors,
	# and use --remote-name so that we can just use the URI.
	curl --location --remote-name "$*"
}

# Documents.
mkdir --parents documents/
cd documents/
# Text and ebooks
download "http://www.gutenberg.org/cache/epub/1/pg1.txt"
download "http://www.gutenberg.org/cache/epub/1/pg1.epub"
download "http://www.gutenberg.org/cache/epub/1/pg1.mobi"
# Daisy E-reader format.
download "http://www.daisy.org/samples/202full-text-full-audio/gon-ruby-mp3.zip"
download "http://www.daisy.org/samples/dtbook-xml/great-painters-dtbook-2005-3.zip"
download "http://www.daisy.org/samples/202text-only/wipo-treaty-d202-text-only.zip"
# PDF and similar formats.
download "http://www.irs.gov/pub/irs-pdf/f1040.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/7/73/ASCII.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/7/73/ASCII.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/9/94/Factor_graph.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/f/fa/Equil.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/0/0c/Contactangle.pdf"
download "http://upload.wikimedia.org/wikipedia/commons/e/ea/Constitution_of_the_Republic_of_South_Africa_Amendment_Act_1995_from_Government_Gazette.djvu"
download "http://arxiv.org/hypertex/link.ps"
download "http://arxiv.org/hypertex/link.dvi"
# HTML and XML
download "http://info.cern.ch/"
download "https://www.senate.gov/legislative/LIS/roll_call_lists/vote_menu_112_1.xml"
download "http://jblevins.org/log/xml-tools"
# MS Office formats.
download "http://arxiv.org/e-print/1009.4027v1.docx"
download "http://ia801603.us.archive.org/13/items/UrduBooks_201302/TotalAyatInQuran.xlsx"
download "https://home.archive.org/~mang/local/amazon%20referral%20revenue_files/amazon%20referral%20revenue.pptx"
download "https://archive.org/download/2011-01-01WoordenLogos-rhema.pptx/2011-01-01WoordenLogos-rhema.pptx"
# OpenDocument files.
download "http://ask.libreoffice.org/upfiles/14110339425827288.odb"
download "http://ask.libreoffice.org/upfiles/13719228396115488.odg"
download "http://ask.libreoffice.org/upfiles/13700816801195109.odp"
download "https://transparency.wikimedia.org/data/data_aug2014.ods"
download "http://upload.wikimedia.org/wikipedia/foundation/d/d1/WMF_Admin_Job_Advertisement_Head_of_Business_Development.odt"
download "https://github.com/javigomez/lib_tbs/blob/master/demo/demo_oo_formula.odf?raw=true"
cd -

# Images.
mkdir --parents images/
cd images/
# Raster image formats.
download "http://upload.wikimedia.org/wikipedia/commons/6/6b/Japan_Railway_JRKyushu_Oita_Station_2.jpg"
download "http://upload.wikimedia.org/wikipedia/commons/d/d7/123_Numbers.gif"
download "http://upload.wikimedia.org/wikipedia/commons/f/f8/Cavity_wind_tunnel_setup.tiff"
download "http://upload.wikimedia.org/wikipedia/commons/2/23/050329-birthday1.png"
# Vector image formats.
download "http://upload.wikimedia.org/wikipedia/commons/5/57/Color_icon_white.svg"
download "http://upload.wikimedia.org/wikipedia/commons/f/fd/Animated_pendulum.svg"
download "http://arxiv.org/html/cond-mat/9903007v4/fig3.eps"
cd -

# Audio.
mkdir --parents audio/
cd audio/
download "http://upload.wikimedia.org/wikipedia/commons/b/b0/%22Bebop-rebop%22_early_bop_phrase.mid"
download "http://upload.wikimedia.org/wikipedia/commons/7/7f/Gliss.ogg"
download "http://upload.wikimedia.org/wikipedia/commons/9/98/Beepalert.wav"
download "http://upload.wikimedia.org/wikipedia/commons/b/b2/Bell-ring.flac"
# Wikimedia Commons does not allow .mp3 files.
# https://commons.wikimedia.org/wiki/Commons:File_types
download "https://archive.org/download/scale1/s1.mp3"
cd -

# Video.
mkdir --parents video/
cd video/
download "http://upload.wikimedia.org/wikipedia/commons/b/bb/Triple_conj.ogg"
download "http://upload.wikimedia.org/wikipedia/commons/6/6b/Zingon_-_YouTube.webm"
cd -

# Code.
mkdir --parents code/
cd code/
touch Makefile
touch file.c
touch file.cpp
touch file.sh
touch file.python

touch file.js
touch file.css
touch file.java
touch file.tex
cd -

# XAFS stuff.
mkdir --parents xafs/
cd xafs/
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/AuCl.cif"
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/FeS2.apj"
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/cu.prj"
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/fe.060"
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/cyanobacteria.prj"
download "https://raw.githubusercontent.com/bruceravel/demeter/master/examples/recipes/Methyltin/methyltin.xyz"
download "https://raw.githubusercontent.com/bruceravel/XAS-Education/master/Talks/pimst/images/PbTiO3/list.xyz"
cd -
