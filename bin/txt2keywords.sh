#!/usr/bin/env bash

# txt2keywords.sh - a front-end to txt2keywords.py

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June 26, 2018 - first cut
# August 8, 2020 - simplified; assuming all work is done in the current directory


# configure
WRD='./wrd'

# require
TXT2KEYWORDS='txt2keywords.py'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file>" >&2
	exit
fi

# get input
FILE=$1

# make more sane
mkdir -p $WRD

# initialize
BASENAME=$( basename $FILE .txt )
OUTPUT="$WRD/$BASENAME.wrd"

# do the work and done
$TXT2KEYWORDS $FILE > $OUTPUT
exit

