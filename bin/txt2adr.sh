#!/usr/bin/env bash

# txt2adr.sh - given a file name, output a list of email addresses

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June  26, 2018 - first cut
# August 8, 229  - tweaked for Reader OAIPMH


# configure
ADR='./adr'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file>" >&2
	exit
fi

# get input
FILE=$1

# make more sane
mkdir -p $ADR

# compute I/O names
BASENAME=$( basename $FILE .txt )
OUTPUT="$ADR/$BASENAME.adr"

# extract the data
RECORDS=$( cat $FILE | grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' )

# do more work, conditionally
SIZE=${#RECORDS} 
if [[ $SIZE > 0 ]]; then

	# proces each item in the data
	printf "id\taddress\n" >  "$OUTPUT"
	while read -r RECORD; do
		printf "$BASENAME\t$RECORD\n" >> "$OUTPUT"
	done <<< "$RECORDS"

fi

# done
exit
