from typing import List
from functools import reduce
import operator

def solve (data: List[str], right: int, down: int) -> int:
    position = 0
    row = 0
    result = 0
    width = len(data[0])

    while True:
        try:
            if data[row][position] == '#':
                result += 1
            row += down
            position = (position + right) % width
        except IndexError:
            return result

def main() -> None:
    with open('input', 'r') as fh:
        data = [line.rstrip() for line in fh]
        print(f"Part one: {solve(data, 3, 1)}")

    modes = [(1,1), (3,1), (5,1), (7,1), (1,2)]
    solution = reduce(operator.mul, [solve(data, *mode) for mode in modes])
    print(f'Part two: {solution}')

if __name__ == '__main__':
    main()
