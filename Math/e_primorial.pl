#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 04 September 2015
# Website: https://github.com/trizen

# Compute a new constant, called e-primorial
# using the following formula:
#   1 + sum({n=0, Inf}, 1/n#)
# where 'n#' is the product of the first n primes.

# Example:
#   1 + 1/2 + 1/(2*3) + 1/(2*3*5) + 1/(2*3*5*7)

use 5.010;
use strict;
use warnings;

use bignum (try => 'GMP');
use ntheory qw(forprimes);

my $s = 0;
my $p = 1;

forprimes {
    $s += 1 / ($p *= $_);
}
1000;

say $s;

__END__
0.705230171791800965147431682888248513743607733565505914344254271579448720350814858381153069719904774040199744849124258793026220304812181974452618661012021323159778159738892351792865007915208229244324416883081570696757761526547730409991939570626315095656064297092991040559037018681680261221057850602197069242610518384960529122692938064843534568180026418571495177395781060935455813529379203383024423075030933708131887415
