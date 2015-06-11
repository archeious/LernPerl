#!/usr/bin/perl -w
use strict;
use warnings;

for (keys %ENV) {
    print $_, " => ", $ENV{$_},"\n" ;
}


