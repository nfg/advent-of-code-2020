#!/usr/bin/env raku

sub MAIN(Str $filename = $?FILE.IO.sibling("input").Str) {
    my @data = $filename.IO.split(/\n\n/, :skip-empty);
    say "Part one: {[+] @data.map(&part-one)}";
    say "Part two: {[+] @data.map(&part-two)}";
}

sub part-one($votes is copy) {
    $votes ~~ s:global/\s//;
    return $votes.comb.Set.elems;
}

sub part-two($votes) {
    my $num-people = $votes.split(/\n/).elems;
    my %freq;
    for $votes.lines { %freq{$_}++ for $_.comb.Set; }
    return %freq.keys.grep({ %freq{$_} == $num-people }).elems;
}

DOC CHECK {
    use Test;
    note "Yarr, tests";
    subtest "part one" => sub {
        is part-one("a\nb\nc"), 3, "counts answers";
        is part-one("ab\ncd\nabc"), 4, "counts uniqs only";
    };

    subtest "part two" => sub {
        is part-two("abc"), 3, "all answers for a person are counted";
        is part-two("abbc"), 3, "ignores dupes";
        is part-two("ab\nac\aa"), 1, "all answered a";
        is part-two("ab\nac\nbb"), 0, "no shared answers";
    }

    done-testing;
}
