#!/usr/bin/perl -w
=head1 NAME
second_task - prints on individual lines number range from 5 to 500 using an array 
without using a variable?

=head1 AVAILABILITY
https://github.com/archeious/LernPerl/

=head1 AUTHOR
Jeff Smith - L<https://archeio.us/>
=cut

use strict;
use warnings;

foreach (5..500){
    print "$_\n" unless ~$_&1
}
