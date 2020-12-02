#!/usr/bin/env raku

#2-9 c: ccccccccc
"input".IO.lines.grep({
    my $match = $_ ~~ rx/^ (\d+) "-" (\d+) " " (.) ": " (.*) $ /;
    my ($idx1, $idx2, $letter, $password) = $match.list();
    $password.substr-eq($letter, $idx1 - 1) xor $password.substr-eq($letter, $idx2 - 1);
}).elems.say;
