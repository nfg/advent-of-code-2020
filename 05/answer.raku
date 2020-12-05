#!/usr/bin/env raku

# OK, we don't actually need seat objects, just the ids.
# But I had to refresh myself on raku OOP, so it stays.
class Seat {
    has $.row;
    has $.seat;
    has $.id;
}

sub parse-code($code, $left, $right) returns Int {
    my $max = 0.5;
    return [+] $code.comb.reverse.map({
        $max = ($max * 2).Int;
        $_ eq $left ?? 0 !! $max;
    });
}

sub get-seat ($code) {
    $code ~~ rx/^ (<[F B]>+) (<[L R]>+) $/ or die;
    my ($row-code, $seat-code) = $/.flat;
    my $row = parse-code($row-code, 'F', 'B');
    my $seat = parse-code($seat-code, 'L', 'R');
    my $id = ($row * (2 ** $seat-code.chars)) + $seat;
    return Seat.new(:$row, :$seat, :$id);
}

# What is the highest seat ID on a boarding pass?
sub solve-part1(@seat-ids) {
    return max @seat-ids;
}

# Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.
# What is the ID of your seat?
sub solve-part2 (@seat-ids) {
    # You can return directly from code blocks (not functions!)
    @seat-ids.sort.reduce: {
        $^a + 2 == $^b ?? return $^a + 1 !! $^b;
    };
    die "Seat not found!";
}

#my @seats = $?FILE.IO.sibling("input").lines.map(&get-seat);
my @seat-ids = $?FILE.IO.sibling("input").lines.map(&get-seat).map: *.id;
say "Part 1: {solve-part1(@seat-ids)}";
say "Part 2: {solve-part2(@seat-ids)}";
