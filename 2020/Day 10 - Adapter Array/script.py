from collections import defaultdict
from typing import List

with open("input.txt", "r") as f:
    puzzle_input = [int(s.rstrip()) for s in f.readlines()]

adapter = max(puzzle_input) + 3
puzzle_input.sort()
diffs = defaultdict(list)
print(puzzle_input)
for i, num in enumerate(puzzle_input):
    if i == len(puzzle_input) - 1:
        diffs[abs(num - puzzle_input[i - 1])].append(num)
        diffs[3].append(adapter)
        break

    diffs[abs(num - puzzle_input[i + 1])].append(num)

print(f"1-jolt diffs: {len(diffs.get(1))}")
print(f"3-jolt diffs: {len(diffs.get(3))}")
print(f"Part One: {len(diffs.get(1)) * len(diffs.get(3))}")


def getPossibilities(current, choices) -> List[List[int]]:
    possible = filter(lambda a: a, choices)


print(f"Part Two: {getPossibilities(puzzle_input, puzzle_input)}")
