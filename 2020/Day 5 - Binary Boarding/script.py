# Load input
with open("input.txt", "r") as f:
    puzzle_input = [s.rstrip() for s in f.readlines()]

ids = []
for instructions in puzzle_input:
    seats = list(range(128))
    columns = list(range(8))
    for command in instructions:
        if command == "F":
            seats = seats[:max(1, len(seats)//2)]
        elif command == "B":
            seats = seats[len(seats)//2:]
        elif command == "R":
            columns = columns[len(columns)//2:]
        elif command == "L":
            columns = columns[:max(1, len(columns)//2)]
    ids.append((seats[0] * 8) + columns[0])

print(f"Highest ID: {max(ids)}")
ids.sort()
print(f"My Id: {next(id+1 for i, id in enumerate(ids) if ids[i+1] != id+1)}")