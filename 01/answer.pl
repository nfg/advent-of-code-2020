#!/usr/bin/env perl

no crap;
use experimentals;

use Path::Tiny;

my $target = 2020;

my @list = path('input')->lines_utf8({ chomp => 1});
while(my $head = shift @list) {
    foreach my $ele (@list) {
        next unless $ele + $head == $target;
        say $ele * $head;
        exit 0;
    }
}
say ":(";
exit 1;

__END__

Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.

Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

For example, suppose your expense report contained the following:
