#!/usr/bin/env perl

# harvest-bibliographics.pl - given a base URL pointing to an (OJS) OAI repository, output rudimentary bibliogrpahic information

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# August 8, 2020 - first documentation


# require
use Net::OAI::Harvester;
use strict;

# get input
my $baseurl    = $ARGV[ 0 ];
my $identifier = $ARGV[ 1 ];
if ( ! $baseurl || ! $identifier ) { die "Usage: $0 <base url> <identifier>\n" }

# initialize
my $harvester = Net::OAI::Harvester->new( 'baseURL' => $baseurl );
binmode( STDOUT, ':utf8' );
binmode( STDERR, ':utf8' );

# get the given record
my $record = $harvester->getRecord( 'identifier' => $identifier, 'metadataPrefix' => 'oai_dc' );

# parse
my $header   = $record->header();
my $metadata = $record->metadata();

# parse some more
my $identifier = $header->identifier();
my $author     = join( '; ', $metadata->creator() );
my $title      = $metadata->title();
my $date       = $metadata->date();
my $source     = ( $metadata->source() )[ 0 ];
my $publisher  = $metadata->publisher();
my $language   = $metadata->language();
my $doi        = ( $metadata->identifier() )[ 1 ];
my $url        = $metadata->relation();
my $abstract   = $metadata->description();

# tidy
$abstract =~ s/&nbsp;/ /g;
$abstract =~ s/\r/ /g;
$abstract =~ s/\n/ /g;
$abstract =~ s/ +/ /g;
$title =~ s/ +/ /g;
$url   =~ s/view/download/g;

# debug
warn "  identifier: $identifier\n";
warn "   author(s): $author\n";
warn "       title: $title\n";
warn "        date: $date\n";
warn "      source: $source\n";
warn "   publisher: $publisher\n";
warn "    language: $language\n";
warn "         doi: $doi\n";
warn "         URL: $url\n";
warn "    abstract: $abstract\n";
warn "\n";

# output and done
print "$identifier\t$author\t$title\t$date\t$source\t$publisher\t$language\t$doi\t$url\t$abstract\n";
exit;


