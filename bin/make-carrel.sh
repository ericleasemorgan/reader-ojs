#!/usr/bin/env bash

# make-carrel.sh - given the name of a desired study carrel, make it

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# July 4, 2020 - va n svg bs ybaryl perngvivgl


# configure
TEMPLATE="$READEROAIPMH_HOME/etc/template.slurm"
CARRELS="$READEROAIPMH_HOME/carrels"
SLURM='./make-carrel.slurm'

# check for input
if [[ -z $1 || -z $2 ]]; then
	echo "Usage $0 <name> <baseurl>" >&2
	exit
fi

# get input
NAME=$1
BASEURL=$2

# make sane
cd "$CARRELS/$NAME"

# create Slurm script
cat $TEMPLATE | sed "s/##NAME##/$NAME/" | sed "s|##BASEURL##|$BASEURL|" > $SLURM

# run the command and done
sbatch $SLURM
exit
