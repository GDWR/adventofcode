from pprint import pprint
from typing import List

with open("input.txt", "r") as f:
    puzzle_input = [s.rstrip() for s in f.readlines()]


class Layout:
    def __init__(self, layout: List[str]):
        self.layout = layout

    def getAdjacent(self, x, y) -> List[str]:
        adjacent_seats = []
        if x != 0:
            adjacent_seats.append(self.layout[y][x-1])

        if y != 0:
            adjacent_seats.append(self.layout[y-1][x])

        if y != 0 and x != 0:
            adjacent_seats.append(self.layout[y-1][x-1])

        if x != len(self.layout[0])-1:
            adjacent_seats.append(self.layout[y][x+1])

        if y != len(self.layout)-1:
            adjacent_seats.append(self.layout[y+1][x])

        if x != len(self.layout[0])-1 and y != len(self.layout)-1:
            adjacent_seats.append(self.layout[y+1][x+1])

        if x != len(self.layout[0])-1 and y != 0:
            adjacent_seats.append(self.layout[y-1][x+1])

        if x != 0 and y != len(self.layout)-1:
            adjacent_seats.append(self.layout[y+1][x-1])

        return adjacent_seats

    def cycle(self) -> bool:
        new_layout = []
        change = False

        for i, row in enumerate(self.layout):
            new_row = []
            for j, seat in enumerate(row):
                if seat == "L" and "#" not in self.getAdjacent(j, i):
                    new_row.append("#")
                    change = True
                elif seat == "#" and self.getAdjacent(j, i).count('#') >= 4:
                    new_row.append("L")
                    change = True
                else:
                    new_row.append(seat)
            new_layout.append(''.join(new_row))
        self.layout = new_layout
        return change

layout = Layout(puzzle_input)

while layout.cycle(): pass

counter = 0
for row in layout.layout:
    counter += row.count('#')
print(f"PartOne: {counter}")