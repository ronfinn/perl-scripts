#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 10 May 2016
# Website: https://github.com/trizen

# Calculate PI by computing the numerator and the denominator fraction that approaches the value of PI.
# It's based on the continued fraction: n^2 / (2n+1)

# See: http://oeis.org/A054766
#      http://oeis.org/A054765

use 5.010;
use strict;
use warnings;

use Memoize qw(memoize);
use Math::BigNum qw(:constant);

no warnings 'recursion';

memoize('pi_numerator');
memoize('pi_denominator');

sub pi_numerator {
    my ($n) = @_;
    $n < 2 ? ($n == 0 ? 1 : 0) : (2 * $n - 1) * pi_numerator($n - 1) + ($n - 1)**2 * pi_numerator($n - 2);
}

sub pi_denominator {
    my ($n) = @_;
    $n < 2 ? $n : (2 * $n - 1) * pi_denominator($n - 1) + ($n - 1)**2 * pi_denominator($n - 2);
}

my $prec = 1000;
my $pi = (4 / (1 + pi_numerator($prec) / pi_denominator($prec)))->as_float(int($prec / (1.32)));
say $pi;