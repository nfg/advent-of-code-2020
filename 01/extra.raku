
#!/usr/bin/env raku

my Int @lines = 'input'.IO.lines.map: *.Int;
my $target = 2020;

my @answer = @lines.combinations(3).race.first: *.sum == $target;
exit 1 unless defined @answer;
say @answer[0] * @answer[1] * @answer[2];
