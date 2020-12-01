import sys

TARGET = 2020

lines = []
with open('input', 'r') as fh:
    lines = [int(line) for line in fh]

while lines:
    head = lines.pop()
    backup = list(lines)

    while lines:
        head2 = lines.pop()
        for ele in lines:
            if head + head2 + ele == TARGET:
                print(head * head2 * ele)
                sys.exit(0)
    lines = backup

print(":(")
sys.exit(1)
