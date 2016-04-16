#!/usr/bin/perl

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Data::Dumper;

sub change {
    my $amount = shift || die "Missing parameter: Cannot give change for non-existent values";
    my $currency = shift || {  # USD is the default currency if none is provided
        base => 100,
        units => [
            {name => 'Five Hundred Dollar Bill', value => 50000},  
            {name => 'One Hundred Dollar Bill',  value => 10000},  
            {name => 'Fifty Dollar Bill',        value => 5000},  
            {name => 'Twenty Dollar Bill',       value => 2000},  
            {name => 'Ten Dollar Bill',          value => 1000},  
            {name => 'Five Dollar Bill',         value => 500},  
            {name => 'Dollar Bill',              value => 100},  
            {name => 'Quarter',                  value => 25},  
            {name => 'Dime',                     value => 10},  
            {name => 'Nickel',                   value => 5},  
            {name => 'Penny',                    value => 1},  
        ]
    };
    
    die "Currency is missing base value" unless exists $currency->{base};  
    $amount = $amount * $currency->{base}; 
    my $change = { };   

    die "Currency units are missing" unless exists $currency->{units};  
    die "Must declare are least one currency units" unless @{$currency->{units}} > 0;  
    do {
        my $unit = shift $currency->{units};
        die "Missing currency unit name" unless exists $unit->{name};  
        die "Currency unit $unit->{name} is missing a value" unless exists $unit->{value};  
        die "Currency unit $unit->{name} is not a number" unless looks_like_number($unit->{value});  
        die "Currency unit $unit->{name} is not positive" unless $unit->{value} > 0; 
        if ($amount >= $unit->{value}) {
            my $numOfUnits = int($amount/$unit->{value});
            $change->{$unit->{name}} = $numOfUnits;
            $amount -= $numOfUnits * $unit->{value};
        }
    # if the remaining amount or currency units run out bail out of the loop        
    } while ($amount > 0 && @{$currency->{units}} > 0);  
    return $change;
}

print "Change for 1234.56 with US currency\n" .Data::Dumper->Dumper(change(1234.56))."\n";

my $fiveAndDime = { 
    base => 100,
    units => [
        {name => 'Dime',                     value => "10"},  
        {name => 'Nickel',                   value => 5},  
    ]
};

print "Change for 1234.56 at a Five and Dime store (aka only nickels and dimes)\n". 
    Data::Dumper->Dumper(change(1234.56,$fiveAndDime))."\n";
    
    