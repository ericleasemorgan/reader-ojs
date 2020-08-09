#!/usr/bin/env bash

# oaiphm2carrel.sh - given the root of an OAIPMH data repository, create a Distant Reader study carrel

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# August 8, 2020 - based on reader-trust
# August 9, 2020 - added command-line input


# example repositories:
#  Advances in Language and Literary Studies (alls) - http://www.journals.aiac.org.au/index.php/alls/oai
#  Theological Librarianship (theolib) - https://serials.atla.com/theolib/oai
#  Information Technology and Libraries (ital) - https://ejournals.bc.edu/index.php/ital/oai
#  International Journal of Librarianship (ijol) - http://ojs.calaijol.org/index.php/ijol/oai
#  International Journal of Literary Linguistics (ijll) - https://journals.linguistik.de/ijll/oai

# enhance environment
PERL_HOME='/export/perl/bin'
JAVA_HOME='/export/java/bin'
PYTHON_HOME='/export/python/bin'
PATH=$PYTHON_HOME:$PERL_HOME:$JAVA_HOME:$PATH
export PATH

# configure
CARRELS="$READEROAIPMH_HOME/carrels"
CORPUS="./etc/reader.txt"
DB='./etc/reader.db'
REPORT='./etc/report.txt'
METADATA='./metadata.tsv'
CACHE='./cache'
TXT='./txt'

# get input
if [[ -z $1 ]]; then
	echo "Usage: $0 <baseurl>" >&2
	exit
fi
OAIPMHDATAREPOSITORY=$1

# require
INITIALIZECARREL='initialize-carrel.sh'
OAI2CORUS='oai2corpus.sh'
METADATA2DB='metadata2db.sh'
FILE2TXT='file2txt.sh'
TIKA='/export/lib/tika/tika-server.jar'
MAP='map.sh'
REDUCE='reduce.sh'
DB2REPORT='db2report.sh'
MAKEPAGES='make-pages.sh'
CARREL2ZIP='carrel2zip.pl'

# get the name of newly created directory
NAME=$( pwd )
NAME=$( basename $NAME )
echo "Carrel name: $NAME" >&2

# create a study carrel
echo "Creating study carrel named $NAME" >&2
$INITIALIZECARREL $NAME

# create a corpus; get metadata and then cache documents
echo "Creating corpus from $OAIPMHDATAREPOSITORY" >&2
$OAI2CORUS $OAIPMHDATAREPOSITORY

# update database with metadata
echo "Updating database with metadata" >&2
$METADATA2DB

# build the carrel; the magic happens here
echo "Building study carrel named $NAME" >&2

# start tika
java -jar $TIKA &
PID=$!
sleep 10

# transform cache to plain text files
find $CACHE -type f | parallel $FILE2TXT {} $TXT

# extract parts-of-speech, named entities, etc
$MAP

# shutdown TIKA
kill $PID

# build the database
$REDUCE

# build ./etc/reader.txt; a plain text version of the whole thing
echo "Building ./etc/reader.txt" >&2
rm -rf $CORPUS >&2
find $TXT -name '*.txt' -exec cat {}           >> $CORPUS \;
tr '[:upper:]' '[:lower:]' < $CORPUS           >  ./tmp/corpus.001
tr '[:digit:]' ' '         < ./tmp/corpus.001  >  ./tmp/corpus.002
tr '\n' ' '                < ./tmp/corpus.002  >  ./tmp/corpus.003
tr -s ' '                  < ./tmp/corpus.003  >  $CORPUS

# output a report against the database
$DB2REPORT > $REPORT
cat $REPORT

# create about file
$MAKEPAGES

# zip it up
echo "Zipping study carrel" >&2
$CARREL2ZIP $NAME
cp ./etc/reader.zip ./study-carrel.zip

# done
echo "Done building $NAME" >&2
exit
