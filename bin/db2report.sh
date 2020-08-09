#!/usr/bin/env bash

# db2report.sh - given a "study carrel", output a canned SQL reqport

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# July 10, 2018 - first cut


# configure
QUERIES="./etc/queries.sql"
DB='./etc/reader.db'


# do the work
cat $QUERIES | sqlite3 $DB

