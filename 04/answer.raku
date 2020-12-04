#!/usr/bin/env raku

my @validation = (
    {
        name => "byr", # Birth Year
        required => True,
        validation => { $_.Int && 1920 <= $_ <= 2002 }
    },
    {
        name => "iyr", # Issue Year
        required => True,
        validation => { $_.Int && 2010 <= $_ <= 2020 }
    },
    {
        name => "eyr", # Expiration Year
        required => True,
        validation => { $_.Int && 2020 <= $_ <= 2030 }
    },
    {
        name => "hgt", # Height
        required => True,
        validation => sub ($val) {
            my $matches = $val ~~ rx/ ^ (\d+) (cm|in) $ /
                or return False;
            if $matches[1] eq 'cm' {
                return 150 <= $matches[0] <= 193;
            }
            return 59 <= $matches[0] <= 76;
        }
    },
    {
        name => "hcl", # Hair Colour
        required => True,
        validation => { so $_ ~~ rx/^ "#" <[ 0 .. 9 a .. f ]> ** 6 $ / },
    },
    {
        name => "ecl", # Eye Colour
        required => True,
        validation => { so $_ eq ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth').one }
    },
    {
        name => "pid", # Passport ID
        required => True,
        validation => { so $_ ~~ rx/^ \d ** 9 $/ }
    },
    {
        name => "cid", # Country ID
        required => False,
        validation => { True }
    }
);

sub parse_raw_passport ($passport) {
    return $passport.split(/\s/, :skip-empty(True)).map({
        my $match = m/^ (.*) ":" (.*) $/ or die;
        $match[0] => $match[1]
    }).Hash;
}

my @data = "input".IO.split(/\n\n/).map(&parse_raw_passport);

sub validate_passport($passport, $strict) {
    for @validation -> $field {
        if ($field<required> && ! defined $passport{$field<name>}) {
            return False;
        }
        if ($strict && ! $field<validation>($passport{$field<name>})) {
            return False;
        }
    }
    return True;
}

sub solve (@passports, $validate) {
    return @passports.grep({ validate_passport($_, $validate) }).elems;

}
say "Part one: {solve(@data, False)}";
say "Part two: {solve(@data, True)}";
