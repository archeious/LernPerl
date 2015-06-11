#!/usr/bin/perl -w
use strict;
use warnings;

my $count = 0;
for (@INC) {
    print "$_ ";
    if ($count++%2==0) { print "\n"; }
}
if ($count%2==1) { print "\n"; } #clean up output on odd number of entries
