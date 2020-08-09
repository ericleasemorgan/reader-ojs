#!/usr/bin/env bash

# list-questions.sh - given a study carrel, output all its questions; a front-end to list-questions.pl

# Eric Lease Morgan <emorgan@nd.edu>
# August 17, 2019 - while investigating Philadelphia as a place to "graduate"


# configure
LISTQUESTIONS='list-questions.pl'
TXT='./txt'

# do the work and done
find $TXT -name "*.txt"| while read FILE; do echo $( basename $FILE .txt ); done | parallel $LISTQUESTIONS
exit
