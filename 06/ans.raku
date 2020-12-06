#!/usr/bin/env raku

my @data = $?FILE.IO.sibling("input").split(/\n\n/, :skip-empty);

say "Part one";
say [+] @data.map({ S:global/\s//.comb.Set.elems });

say "Part two";
say [+] @data.map({
    my $num-people = $_.split(/\n/).elems;
    my %freq;
    %freq{$_}++ for S:global/\s//.comb;
    %freq.keys.grep({ %freq{$_} == $num-people }).elems;
});
