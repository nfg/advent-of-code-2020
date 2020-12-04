#!/usr/bin/env raku

my @lines = "input".IO.lines;
my $max = @lines[0].chars; # Length of string.

sub solve(Int $right, Int $down) {
    my ($count, $position, $row) = 0, 0, 0;

    loop {
        $count++ if @lines[$row].substr($position, 1) eq '#';
        $row += $down;
        return $count unless defined @lines[$row];
        $position = ($position + $right) % $max;
    }
}

say "Part 1: {solve(3,1)}\n";

my @modes = [[1,1], [3,1], [5,1], [7,1], [1,2]];
my @answers = @modes.map({
    # |$_ takes the list in $_ and explodes it into arguments.
    my ($right, $down) = |$_;
    my $answer = solve($right, $down);
    say "For right {$right} and down {$down}, the answer is {$answer}";
    $answer;
});

say "Part 2: {[*] @answers}";
