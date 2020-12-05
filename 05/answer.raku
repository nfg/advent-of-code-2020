#!/usr/bin/env raku

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
sub solve-part1(@seats) {
    return @seats.sort({ .id }).tail.id;
}

# Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.
# What is the ID of your seat?
sub solve-part2 (@seats) {
    my ($prev-id, @ids) = @seats.map({ .id }).sort;
    for @ids -> $next-id {
        return $prev-id + 1 if $prev-id + 2 == $next-id;
        $prev-id = $next-id;
    }
    die;
}

my @seats = $?FILE.IO.sibling("input").lines.map(&get-seat);
say "Part 1: {solve-part1(@seats)}";
say "Part 2: {solve-part2(@seats)}";
