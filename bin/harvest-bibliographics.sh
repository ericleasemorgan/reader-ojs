#!/usr/bin/env bash

# harvest-bibliographics.sh - a front-end to harvest-bibliographics.pl

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# August 8, 2020 - first documentation

 
# configure
TMP='./tmp/bibliographics'

# require
HARVESTBIBLIOGRAPHICS='harvest-bibliographics.pl'

# sanity check
if [[ -z $1 || -z $2 ]]; then

	echo "Usage: $0 <base url> <identifier>" >&2
	exit
fi

# initialize
BASEURL=$1
IDENTIFIER=$2

# make sane
mkdir -p $TMP

# compute output, do the work (conditional), and done
OUTPUT="$TMP/$( echo $IDENTIFIER | cut -d '/' -f2 ).tsv"
if [[ ! -e $OUTPUT ]]; then $HARVESTBIBLIOGRAPHICS "$BASEURL" "$IDENTIFIER" > $OUTPUT; fi
exit