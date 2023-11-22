import math
from typing import List

# Load input
with open("input.txt", "r") as f:
    puzzle_input = [s.rstrip() for s in f.readlines()]


class Toboggan:
    def __init__(self, string: List[str]):
        self._map: List[List[str]] = [list(char) for char in string]

    def calculate_slope(self, right: int, down: int):
        treeCounter = 0
        x = 0
        map = [x for i, x in enumerate(self._map) if i % down == 0]

        for row in map:
            if row[x] == "#":
                treeCounter += 1
            x = (x+right) % len(row)
        return treeCounter


toboggan = Toboggan(puzzle_input)
print(f"Part One Tree Count: {toboggan.calculate_slope(3, 1)}")

slopes = [toboggan.calculate_slope(1, 1), toboggan.calculate_slope(3, 1),
          toboggan.calculate_slope(5, 1), toboggan.calculate_slope(7, 1), toboggan.calculate_slope(1, 2)]

print(f"Part Two: {math.prod(slopes)}")
