#!/usr/bin/env perl

# harvest-identifiers.pl - given a base URL pointing to an (OJS) OAI repository, output rudimentary bibliogrpahic information


# require
use Net::OAI::Harvester;
use strict;

# get input
my $baseurl = $ARGV [ 0 ];
if ( ! $baseurl ) { die "Usage: $0 <oaipmh data repository url>\n" }

# initialize
my $harvester = Net::OAI::Harvester->new( 'baseURL' => $baseurl );
binmode( STDOUT, ':utf8' );
binmode( STDERR, ':utf8' );

# get all identifiers and then process each one
my $identifiers = $harvester->listAllIdentifiers( 'metadataPrefix' => 'oai_dc' );
while ( my $identifier = $identifiers->next() ) {

    # parse, debug, and output
    my $identifier = $identifier->identifier();
   	warn "$identifier\n";
   	print "$identifier\n";
   		
}

# done
exit;


