#!/usr/bin/env bash

# txt2ent.sh - given a file name, run txt2ent.py
# usage: find carrels/word2vec/txt -name '*.txt' -exec ./bin/txt2ent.sh {} \;
# usage: find carrels/asist/txt -name '*.txt' -exec qsub -N TXT2ENT -o ./log/txt2ent ./bin/txt2ent.sh {} \;

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June 26, 2018 - first cut


# configure
ENT='./ent'

# require
TXT2ENT='txt2ent.py'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file>" >&2
	exit
fi

# get input
FILE=$1

# make more sane
mkdir -p $ENT

# initialize
BASENAME=$( basename $FILE .txt )
OUTPUT="$ENT/$BASENAME.ent"

# do the work and done
$TXT2ENT $FILE > $OUTPUT
exit

