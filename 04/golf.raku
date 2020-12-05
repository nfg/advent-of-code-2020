#!/usr/bin/env raku

# This is the "golfed" version. OK, not actually, but it uses more language
# features for great(er) succinctness.
#
# I stole the regex logic for hgt from
# https://github.com/codesections/advent-of-raku-2020/blob/main/ggoebel/04b.raku

my %required = (
    byr => { 1920 <= $_ <= 2002 },
    iyr => { 2010 <= $_ <= 2020 },
    eyr => { 2020 <= $_ <= 2030 },
    hgt => {
            rx[
                || ^ (\d+) <?{ 150 <= $/[0].Int <= 193 }> "cm" $
                || ^ (\d+) <?{ 59  <= $/[0].Int <= 76  }> "in" $
            ]
        },
    hcl => { so $_ ~~ rx/^ "#" <[ 0 .. 9 a .. f ]> ** 6 $ / },
    ecl => { $_ (elem) <amb blu brn gry grn hzl oth> },
    pid => { so $_ ~~ rx/^ \d ** 9 $/ }
);
my @all-fields = 'cid', |%required.keys;

sub parse-raw-passport ($passport --> Hash) {
    return $passport.split(/\s/, :skip-empty).map({
        m/^ (.*) ":" (.*) $/ or die;
        |$/.map: *.Str;
    }).Hash;
}

sub validate-passport (%passport, $strict) returns Bool {
    so all %passport.keys.map: * (elem) @all-fields or die "BUNK PASSPORT!";
    return so all %required.kv.map( sub Bool (Str:D $name, Block:D $validation) {
        return False unless %passport{$name}:exists;
        return True unless $strict;
        return $validation(%passport{$name});
    });
}

sub solve (@passports, :$strict=False) returns Int {
    return @passports.grep({ validate-passport($_, $strict) }).elems;
}

my @data = $?FILE.IO.sibling("input").split(/\n\n/).map(&parse-raw-passport);
say "Part one: {solve(@data)}";
say "Part two: {solve(@data, :strict)}";
