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

################################################################################

sub parse_raw_passport ($passport) {
    return $passport.split(/\s/, :skip-empty(True)).map({
        my $match = m/^ (.*) ":" (.*) $/ or die;
        $match[0] => $match[1]
    }).Hash;
}

sub validate_passport($passport, $strict) {
    # "so" coerces to boolean.
    # "all" takes the right-side element and turns it into a junction.
    # In this case, all the values must pass validation.
    # sub (% (:$required ...) basically takes a hash and destructures it.
    # :D = "must be defined".
    return so all @validation.map(sub (% (Bool:D :$required, Str:D :$name, Block:D :$validation) ) {
        return False if $required && ! defined $passport{$name};
        return ! $strict || $validation($passport{$name});
    });
}

sub solve (@passports, $strict) {
    return @passports.grep({ validate_passport($_, $strict) }).elems;

}

my @data = "input".IO.split(/\n\n/).map(&parse_raw_passport);

say "Part one: {solve(@data, False)}";
say "Part two: {solve(@data, True)}";
