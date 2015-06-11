#!/usr/bin/perl -w
use strict;
use warnings;
use B::Deparse ();


$SIG{TERM} = sub { print "Control+C was pressed\n" };

for (keys %SIG) {
    if (defined $SIG{$_}) {
        my $pv = $_ . " => ";
        my $deparse = B::Deparse->new;
        if (!ref($SIG{$_})) {
            $pv .= $SIG{$_};
        } else {
            if  (UNIVERSAL::isa($SIG{$_},'CODE')) {
                $pv .= $deparse->coderef2text($SIG{$_});
            }
        }
        print $pv."\n";
    }
}


