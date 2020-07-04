#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 04 October 2017
# https://github.com/trizen

# Generates a Mandelbrot-like set, using the formula: z = z^(1/c).

# See also:
#   https://en.wikipedia.org/wiki/Mandelbrot_set
#   https://trizenx.blogspot.ro/2017/01/mandelbrot-set.html

use 5.010;
use strict;
use warnings;

use Imager;
use Inline 'C';

sub mandelbrot_like_set {

    my ($w, $h) = (800, 800);

    my $zoom  = 1;    # the zoom factor
    my $moveX = 0;    # the amount of shift on the x axis
    my $moveY = 0;    # the amount of shift on the y axis

    my $L = 100;      # the maximum value of |z|
    my $I = 30;       # the maximum number of iterations

    my $img   = Imager->new(xsize => $w, ysize => $h);
    my $color = Imager::Color->new('#000000');

    foreach my $x (1 .. $w) {
        foreach my $y (1 .. $h) {

            my $i = iterate(
                (2 * $x - $w) / ($w * $zoom) + $moveX,
                (2 * $y - $h) / ($h * $zoom) + $moveY,
                $L, $I,
            );

            $color->set(hsv => [$i / $I * 360 - 120, 1, $i / $I]);
            $img->setpixel(x => $x - 1, y => $y - 1, color => $color);
        }
    }

    return $img;
}

mandelbrot_like_set()->write(
    file => 'mandelbrot_like_set.png'
);

__END__
__C__

#include <complex.h>

int iterate(double zx, double zy, int L, int i) {
    double complex z = zx + zy * I;
    double complex c = 1/z;
    while (cabs(z) < L && --i) {
        z = cpow(z, c);
    }
    return i;
}
