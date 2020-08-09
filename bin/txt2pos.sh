#!/usr/bin/env bash

# txt2pos.sh - given a file name, run txt2pos.py

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June 26, 2018 - first cut


# configure
POS='./pos'

# require
TXT2POS='txt2pos.py'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file>" >&2
	exit
fi

# get input
FILE=$1

# make more sane
mkdir -p $POS

# compute output
BASENAME=$( basename $FILE .txt )
OUTPUT="$POS/$BASENAME.pos"

# do the work and done
$TXT2POS $FILE > $OUTPUT
exit





