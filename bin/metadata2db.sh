#!/usr/bin/env bash

# metadata2db.sh - given a TSV (of specific shape) update a study carrel database

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# August 8, 2020 - first cut


# configure
DB='./etc/reader.db'
METADATA='./metadata.tsv'
TMP='./tmp'
BIBLIOGRAPHICS="$TMP/bibliographics.sql"
TRANSACTION="$TMP/update-bibliographics.sql"

# require
METADATA2SQL='metadata2sql.py'

# create bibliographic insert statements
$METADATA2SQL $METADATA > $BIBLIOGRAPHICS

# create a transaction
echo "BEGIN TRANSACTION;"    >  $TRANSACTION
cat $BIBLIOGRAPHICS          >> $TRANSACTION
echo "END TRANSACTION;"      >> $TRANSACTION

# do the work and one
cat $TRANSACTION | sqlite3 $DB
exit
