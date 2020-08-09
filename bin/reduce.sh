#!/usr/bin/env bash

# reduce.sh - given a directory, build (reduce) a database

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June 28, 2018 - first cut
# June 21, 2020 - started to change how reduce works, somewhat sucessfully


# addresses
echo "===== Reducing email addresses" >&2
mkdir -p ./tmp/sql-adr
find ./adr -name "*.adr" | parallel adr2sql.pl
reduce-adr.sh

# keywords
echo "===== Reducing keywords" >&2
mkdir -p ./tmp/sql-wrd
find ./wrd -name "*.wrd" | parallel wrd2sql.pl
reduce-wrd.sh

# urls
echo "===== Reducing urls" >&2
mkdir -p ./tmp/sql-url
find ./urls -name "*.url" | parallel url2sql.pl
reduce-url.sh

# entities
echo "===== Reducing named entities" >&2
mkdir -p ./tmp/sql-ent
find ./ent -name "*.ent" | parallel ent2sql.pl
reduce-ent.sh

# pos
echo "===== Reducing parts of speech" >&2
mkdir -p ./tmp/sql-pos
find ./pos -name "*.pos" | parallel pos2sql.pl
reduce-pos.sh

# bib
echo "===== Reducing bibliographics" >&2
find ./bib -name '*.bib' -exec reduce.pl bib {} \;

# done
exit
