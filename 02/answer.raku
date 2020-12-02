#!/usr/bin/env raku

#2-9 c: ccccccccc
my $found = 0;
for "input".IO.lines -> $line {
    my $match = $line ~~ rx/^ (\d+) "-" (\d+) " " (.) ": " (.*) $ /;

    # There has to be a smarter way of coercing types.
    my ($at_least, $at_most, $letter, $password) = $match.list();
    my $pass_match = $password ~~ m:global / $letter /;
    if $at_least.Int <= $pass_match.elems <= $at_most {
        ++$found
    }
}
say "FOUND: {$found}";
