#!/usr/bin/perl -w
use strict;
use warnings;
use B::Deparse ();

# setup and examplar of a custom anomymous signal handler
$SIG{TERM} = sub { print "Terminating\n"; exit(); };

# setup and examplar of a custom name subroutine signal handler
sub interrupt { print "Interrupting.. but alas not terminating\n"; exit(); };
$SIG{INT} = \&interrupt;

foreach my $key (keys %SIG) {
    my $value = $SIG{$key};
    if (defined $value) {
        my $pv = $key . " => ";
        my $deparse = B::Deparse->new;
        if (!ref($value)) { # check if the value is a reference
            $pv .= $value; # the value is just a text value of another handler
        } else {
            if  (UNIVERSAL::isa($value,'CODE')) { # check if is a refenence to a code block
                $pv .= $deparse->coderef2text($value);
            }
        }
        print $pv."\n";
    }
}


