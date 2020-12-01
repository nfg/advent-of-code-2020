#!/usr/bin/env perl

no crap;
use experimentals;

use Path::Tiny;

my $target = 2020;

my @list = path('input')->lines_utf8({ chomp => 1});

while(scalar(@list) > 3) {
    my $head = shift @list;
    my $length = scalar(@list);
    for (my $idx_mid = 0; $idx_mid < $length - 1 ; $idx_mid++) {
        for (my $idx_end = $idx_mid + 1; $idx_end < $length ; $idx_end++) {
            if ($head + $list[$idx_mid] + $list[$idx_end] == $target) {
                say $head * $list[$idx_mid] * $list[$idx_end];
                exit 0;
            }
        }
    }
}

say ":(";
exit 1;

__END__

In your expense report, what is the product of the three entries that sum to 2020?
