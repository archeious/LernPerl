#!/usr/bin/perl

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Carp qw( croak );
use Data::Dumper;

sub change {
    my $amount = shift || croak 'Missing parameter: Cannot give change for non-existent values';
    my $currency = shift || {  # USD is the default currency if none is provided
        base => 100,
        units => [
            {name => 'Five Hundred Dollar Bill', value => 50_000},
            {name => 'One Hundred Dollar Bill',  value => 10_000},
            {name => 'Fifty Dollar Bill',        value => 5_000},
            {name => 'Twenty Dollar Bill',       value => 2_000},
            {name => 'Ten Dollar Bill',          value => 1_000},
            {name => 'Five Dollar Bill',         value => 500},
            {name => 'Dollar Bill',              value => 100},
            {name => 'Quarter',                  value => 25},
            {name => 'Dime',                     value => 10},
            {name => 'Nickel',                   value => 5},
            {name => 'Penny',                    value => 1},
        ]
    };

    croak 'Amount provided is not a number' unless looks_like_number($amount);
    croak 'Currency is missing base value' unless exists $currency->{base};
    croak 'Currency base value is not a number' unless looks_like_number($currency->{base});
    $amount = $amount * $currency->{base};

    my $change = { };

    croak 'Must declare are least one currency units' unless exists $currency->{units} && @{$currency->{units}} > 0;
    do {
        # Grab next currency unit
        my $unit = shift $currency->{units};
        croak 'Missing currency unit name' unless exists $unit->{name};
        croak "Currency unit $unit->{name} is missing a value" unless exists $unit->{value};
        croak "Currency unit $unit->{name} is not a number" unless looks_like_number($unit->{value});
        croak "Currency unit $unit->{name} is not positive" unless $unit->{value} > 0;
        if ($amount >= $unit->{value}) {
            my $numOfUnits = int($amount/$unit->{value});
            $change->{$unit->{name}} = $numOfUnits;
            $amount -= $numOfUnits * $unit->{value};
        }
    # if the remaining amount or currency units run out bail out of the loop
    } while ($amount > 0 && @{$currency->{units}} > 0);
    return $change;
}

print "Change for 1234.56 with US currency\n" . Data::Dumper->Dumper(change(1234.56)) . "\n";

my $fiveAndDime = {
    base => 100,
    units => [
        {name => 'Dime',                     value => '10'},
        {name => 'Nickel',                   value => 5},
    ]
};

print "Change for 1234.56 at a Five and Dime store (aka only nickels and dimes)\n".
    Data::Dumper->Dumper(change(1234.56,$fiveAndDime))."\n";
 