# Load input
with open("input.txt", "r") as f:
    entries = f.read().split("\n")
    puzzleInput = []
    last = 0
    for i, element in enumerate(entries):
        if not element:
            puzzleInput.append(" ".join(entries[last:i]))
            last = i

print(f"PartOne: {sum(map(len,map(set,puzzleInput)))}")


allAnsweredYesCount = 0
for group in [i.split() for i in puzzleInput]:
    uniques = set(char for answer in group for char in answer)
    for unique in uniques:
        if all(unique in answer for answer in group):
            allAnsweredYesCount += 1

print(f"Part Two: {allAnsweredYesCount}")