# Load input
with open("input.txt", "r") as f:
    puzzle_input = [int(num) for num in f.readlines()]


# Part one
def partOne_find_2020(array) -> int:
    array.sort()  # Start with lowest and compare to highest, should be slightly quicker
    tries = 0
    for num in array:
        for i in range(len(array)):
            if num + array[len(array) - 1 - i] == 2020:
                print(tries)
                return num * array[len(array) - 1 - i]
            else:
                tries += 1


# Part two, nothing special
def partTwo_find_2020(array) -> int:
    for numOne in array:
        for numTwo in array:
            for numThree in array:
                if numOne + numTwo + numThree == 2020:
                    return numOne * numTwo * numThree


print(f"Part One Answer: {partOne_find_2020(puzzle_input)}")
print(f"Part Two Answer: {partTwo_find_2020(puzzle_input)}")
