#!/usr/bin/env raku

my Int @lines = 'input'.IO.lines.map: *.Int;
my $target = 2020;

while (my $head = @lines.shift) {
    my $found = @lines.first: * + $head == $target;
    if (defined $found) {
        say $found * $head;
        exit 0;
    }
}
exit 1;
