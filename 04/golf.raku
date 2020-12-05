#!/usr/bin/env raku

# This is the "golfed" version. 10x more succinct.

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
    ecl => { so $_ eq ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth').one },
    pid => { so $_ ~~ rx/^ \d ** 9 $/ }
    # "cid" is optional
);

sub parse_raw_passport ($passport --> Hash) {
    return $passport.split(/\s/, :skip-empty).map({
        m/^ (.*) ":" (.*) $/ or die;
        $/.Slip;
    }).Hash;
}

sub validate_passport-new($passport, $strict) returns Bool {
    return so %required.kv.map( sub Bool (Str:D $name, Block:D $validation) {
        return False unless $passport{$name}:exists;
        return True unless $strict;
        return $validation($passport{$name});
    }).all;
}

sub solve (@passports, :$strict=False) returns Int {
    return @passports.grep({ validate_passport-new($_, $strict) }).elems;

}

my @data = $?FILE.IO.sibling("input").split(/\n\n/).map(&parse_raw_passport);
say "Part one: {solve(@data)}";
say "Part two: {solve(@data, :strict)}";
