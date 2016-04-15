#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

sub change {
    print  "args:". Data::Dumper->Dumper(@_)."\n";
    my $amount = shift;
    my @currency  =  $_[0] || (
        {name => 'Five Hundred Dollar Bill', value => 500},  
        {name => 'One Hundred Dollar Bill',  value => 100},  
        {name => 'Fifty Dollar Bill',        value => 50},  
        {name => 'Twenty Dollar Bill',       value => 20},  
        {name => 'Ten Dollar Bill',          value => 10},  
        {name => 'Five Dollar Bill',         value => 5},  
        {name => 'Dollar Bill',              value => 1},  
        {name => 'Quarter',                  value => 0.25},  
        {name => 'Dime',                     value => 0.10},  
        {name => 'Nickel',                   value => 0.05},  
        {name => 'Penny',                    value => 0.01},  
    );
    print  "currency". Data::Dumper->Dumper(@currency)."\n";
    my $change = {};    
    do {
        my $unit = shift @currency;
        print  "unit:". Data::Dumper->Dumper($unit)."\n";
        if ($amount >= $unit->{value}) {
            my $numOfUnits = int($amount/$unit->{value});
            $change->{$unit->{name}} = $numOfUnits;
            $amount -= $numOfUnits * $unit->{value};
        }        
    } while ($amount > 0);
    return $change;
}

print  Data::Dumper->Dumper(change(1234.0,[{name=>'Dimes', value=>'0.10'},{name=>'Nickels',value=>'0.05'},]))."\n";