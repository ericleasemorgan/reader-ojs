#!/usr/bin/env bash

# oai2corpus.sh - given an OAI-PMH data respository URL, fill a Reader cache and create a metadata file

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# August 8, 2020 - first cut


# configure
TMP='./tmp'
IDENTIFIERS="$TMP/identifiers.txt"
HEADER='identifier\tauthor\ttitle\tdate\tsource\tpublisher\tlanguage\tdoi\turl\tabstract\n'
METADATA='./metadata.tsv'

# require
HARVESTIDENTIFIERS="harvest-identifiers.pl"
HARVESTBIBLIOGRAPHICS="harvest-bibliographics.sh"
HARVESTPDF="harvest-pdf.sh"

# sanity check
if [[ -z "$1" ]]; then
	echo "Usage: $0 <oaipmh data repository url>" >&2
	exit
fi

# initialize
BASEURL=$1

# cache the identifiers
mkdir -p $TMP
$HARVESTIDENTIFIERS $BASEURL > $IDENTIFIERS

# get the bibliographics of each identifier
cat $IDENTIFIERS | parallel $HARVESTBIBLIOGRAPHICS $BASEURL

# clean, normalize, enhance bibliographics here

# create our metadata file; warning, hard-coded path ahead
printf $HEADER                 >  $METADATA
cat ./tmp/bibliographics/*.tsv >> $METADATA

# harvest pdf
tail -n +2 $METADATA | parallel --colsep '\t' $HARVESTPDF {1} {9}

