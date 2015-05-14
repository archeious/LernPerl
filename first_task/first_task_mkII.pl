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

map { printf "%d\n", $_ } (5..500);
