class Password:
    def __init__(self, string: str):
        amount, letter, password = string.split(" ")
        min, max = amount.split("-")
        self.min = self.indexOne = int(min)  # Double var for ease of reading
        self.max = self.indexTwo = int(max)
        self.letter: str = letter[0:-1]
        self.password: str = password[0:-1]

    @property
    def validPartOne(self) -> bool:
        return self.min <= self.password.count(self.letter) <= self.max

    @property
    def validPartTwo(self) -> bool:
        # -1 due to indexing starts from 0
        return (self.password[self.indexOne - 1] == self.letter) ^ (self.password[self.indexTwo - 1] == self.letter)


# Load input
with open("input.txt", "r") as f:
    puzzle_input = [Password(line) for line in f.readlines()]


print(f"Part one valid passwords count: {len([password for password in puzzle_input if password.validPartOne])}")
print(f"Part two valid passwords count: {len([password for password in puzzle_input if password.validPartTwo])}")
