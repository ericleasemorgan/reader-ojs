#!/usr/bin/env bash

# txt2bib.sh - given a file name, extract bibliographics; a front-end to file2bib.py

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June  26, 2018 - first cut
# August 8, 2020 - simplified for Reader OAIPMH


# configure
BIB='./bib'

# require
TXT2BIB='txt2bib.py'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file>" >&2
	exit
fi

# get input
FILE=$1

# compute output
BASENAME=$( basename $FILE .txt )
OUTPUT="$BIB/$BASENAME.bib"

# do the work and done
$TXT2BIB $FILE > $OUTPUT
exit
