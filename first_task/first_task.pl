#!/usr/bin/perl -w

=head1 NAME
first_task - prints on individual lines number range from 5 to 500

=head1 AVAILABILITY 
https://github.com/archeious/LernPerl/

=head1 AUTHOR
Jeff Smith - L<https://archeio.us/>
=cut

use strict;
use warnings;


my $firstNumber = 5;
my $lastNumber = 500;

for (my $i=$firstNumber; $i <= $lastNumber; ++$i) {
  printf "%d\n", $i;
}

