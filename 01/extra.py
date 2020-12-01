import sys

TARGET = 2020

lines = []
with open('input', 'r') as fh:
    lines = [int(line) for line in fh]

while lines:
    head = lines.pop()
    working_set = list(lines)

    while working_set:
        head2 = working_set.pop()
        for ele in working_set:
            if head + head2 + ele == TARGET:
                print(head * head2 * ele)
                sys.exit(0)

print(":(")
sys.exit(1)
