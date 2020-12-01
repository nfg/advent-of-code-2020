import sys

TARGET = 2020

lines = []
with open('input', 'r') as fh:
    lines = [int(line) for line in fh]

while lines:
    head = lines.pop()
    for ele in lines:
        if head + ele == TARGET:
            print(head * ele)
            sys.exit(0)
print(":(")
sys.exit(1)
