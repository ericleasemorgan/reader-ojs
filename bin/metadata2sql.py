#!/usr/bin/env python

# metadata2sql.py - given a TSV file (of a specific shape)), output SQL

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# August 8, 2020 - re-written for reader-oaipmh


# require
import sys
import pandas as pd
import os

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <tsv>\n" )
	quit()

# initialize
tsv = sys.argv[ 1 ]

# read the file and pivot it
metadata = pd.read_csv( tsv, sep='\t' )

# check for known columns; may add fields later
if   'author' in metadata : valid = True
elif 'title'  in metadata : valid = True
elif 'date'   in metadata : valid = True
else                      : valid = False

# check for validity
if valid == False :
	sys.stderr.write( "Invalid metadata file; need at least an author, title, or date column\n" )
	exit()

# pivot the table
metadata.set_index( 'identifier', inplace=True )

# process each row
for id, row in metadata.iterrows() :

	# cache for later use soon
	oaipmhid = id
	
	# initialize id
	id = id.split( '/' )[ 1 ]
	print( "INSERT INTO bib ( 'id' ) VALUES ( '%s' );" % id )

	# oai-pmh identifier
	print( "UPDATE bib SET oaipmhid = '%s' WHERE id is '%s';" % ( oaipmhid, id ) )

	# author
	if 'author' in metadata :
		author = str( row[ 'author' ] )
		author = author.replace( "'", "''" )
		print( "UPDATE bib SET author = '%s' WHERE id is '%s';" % ( author, id ) )
	
	# title
	if 'title' in metadata :
		title = str( row[ 'title' ] )
		title = title.replace( "'", "''" )
		print( "UPDATE bib SET title = '%s' WHERE id is '%s';" % ( title, id ) )
	
	# date
	if 'date' in metadata :
		date = str( row[ 'date' ] )
		date = date.replace( "'", "''" )
		print( "UPDATE bib SET date = '%s' WHERE id is '%s';" % ( date, id ) )
	
	# abstract
	if 'abstract' in metadata :
		abstract = str( row[ 'abstract' ] )
		abstract = abstract.replace( "'", "''" )
		print( "UPDATE bib SET abstract = '%s' WHERE id is '%s';" % ( abstract, id ) )
	
	# url
	if 'url' in metadata :
		url = str( row[ 'url' ] )
		url = url.replace( "'", "''" )
		print( "UPDATE bib SET url = '%s' WHERE id is '%s';" % ( url, id ) )
	
	
	# doi
	if 'doi' in metadata :
		doi = str( row[ 'doi' ] )
		doi = doi.replace( "'", "''" )
		print( "UPDATE bib SET doi = '%s' WHERE id is '%s';" % ( doi, id ) )
	
	# source
	if 'source' in metadata :
		source = str( row[ 'source' ] )
		source = source.replace( "'", "''" )
		print( "UPDATE bib SET source = '%s' WHERE id is '%s';" % ( source, id ) )
	
	# publisher
	if 'publisher' in metadata :
		publisher = str( row[ 'publisher' ] )
		publisher = publisher.replace( "'", "''" )
		print( "UPDATE bib SET publisher = '%s' WHERE id is '%s';" % ( publisher, id ) )
	
	# langauge
	if 'language' in metadata :
		language = str( row[ 'language' ] )
		language = language.replace( "'", "''" )
		print( "UPDATE bib SET language = '%s' WHERE id is '%s';" % ( language, id ) )
	
	# delimit
	print()
	
# done
exit()


