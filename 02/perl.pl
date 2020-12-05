#!/usr/bin/env perl

no crap;
use experimentals;
use Path::Tiny;

sub policy1 ($min, $max, $char, $password) {
    my $count =()= $password =~ m/$char/g;
    return $count >= $min && $count <= $max;
}

sub policy2 ($pos1, $pos2, $char, $password) {
    my $found1 = substr($password, $pos1 - 1, 1) eq $char;
    my $found2 = substr($password, $pos2 - 1, 1) eq $char;
    return $found1 != $found2;
}

my @data = map {
    my @matches = m/^(\d+)-(\d+) (.): (.*)$/ or die;
    \@matches;
} path('input')->lines_utf8({ chomp => 1});

say "Part one: " . scalar grep { policy1(@$_) } @data;
say "Part two: " . scalar grep { policy2(@$_) } @data;
