"""
Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

1-3 a: abcde is valid: position 1 contains a and position 3 does not.
1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.

How many passwords are valid according to the new interpretation of the policies?
"""

import re
import sys

parser = re.compile('^(\d+)-(\d+) (.): (.*)$')
found = 0
with open('input', 'r') as fh:
    for line in fh:
        line = line.rstrip()
        match = parser.match(line)
        if match is None:
            raise Exception(f"Couldn't handle line: {line}")
        idx1, idx2, letter, password = match.groups()
        idx1 = int(idx1) - 1
        idx2 = int(idx2) - 1
        if bool(password[int(idx1)] == letter) != bool(password[int(idx2)] == letter):
            found = found + 1

print(f"FOUND: {found}")
sys.exit(0)
