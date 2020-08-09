#!/usr/bin/env bash

# harvest-pdf.sh - given an identifer and URL, cache a file

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# August 8, 2020 - first documentation


# configure
CACHE='./cache'

# sanity check
if [[ -z $1 || -z $2 ]]; then

	echo "Usage: $0 <identifier> <url>" >&2
	exit
fi

# initialize
IDENTIFIER=$1
URL=$2
OUTPUT="$CACHE/$( echo $IDENTIFIER | cut -d '/' -f2 ).pdf"

# make sane
mkdir -p $CACHE

# debug
echo $IDENTIFIER  >&2
echo $URL         >&2
echo $OUTPUT      >&2
echo              >&2

# do the work, conditionally
if [[ ! -f $OUTPUT ]]; then wget -O $OUTPUT $URL; fi
exit