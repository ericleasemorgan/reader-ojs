#!/usr/bin/env bash

# map.sh - given an directory (of .txt files), map various types of information

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June    27, 2018 - first cut
# July    10, 2018 - started using parallel, and removed files2txt processing
# July    12, 2018 - migrating to the cluster
# February 3, 2020 - tweaked a lot to accomodate large files
# June    22, 2020 - processing txt files, not json files; needs to be tidied
# August   8, 2020 - simplified; assuming all the work is to be done in the current directory


# configure
TXT='./txt';

# require
TXT2ADR='txt2adr.sh'
TXT2URLS='txt2urls.sh'
TXT2KEYWORDS='txt2keywords.sh'
TXT2ENT='txt2ent.sh'
TXT2POS='txt2pos.sh'
TXT2BIB='txt2bib.sh'

# extract various features
find $TXT -name '*.txt' | parallel $TXT2POS      &
find $TXT -name '*.txt' | parallel $TXT2KEYWORDS &
find $TXT -name '*.txt' | parallel $TXT2ENT      &
find $TXT -name '*.txt' | parallel $TXT2ADR      &
find $TXT -name '*.txt' | parallel $TXT2URLS     &
find $TXT -name '*.txt' | parallel $TXT2BIB      & 

# done
wait
echo "Done mapping" >&2
exit
