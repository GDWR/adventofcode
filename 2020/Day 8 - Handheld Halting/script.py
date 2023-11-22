from typing import List

with open("input.txt", "r") as f:
    puzzle_input = [s.rstrip() for s in f.readlines()]


class GameConsole:
    def __init__(self, boot_code: List[str], fix: bool = False):
        self.bootCode = boot_code
        self.originalBootCode = boot_code.copy()
        self.pointer = 0
        self.accumulator = 0
        self._mem = []
        self._memFix = []
        self.fix = fix

    def run(self):
        while self.pointer < len(self.bootCode):
            code = self.bootCode[self.pointer]
            if self.pointer in self._mem:
                if self.fix:
                    self.tryFix()
                    continue
                else:
                    break
            else:
                self._mem.append(self.pointer)
            self.handleCode(code)

    def handleCode(self, code: str):
        split = code.split()
        if split[0] == "jmp":
            if split[1][0] == "+":
                self.pointer += int(split[1][1:])
            else:
                self.pointer -= int(split[1][1:])
        elif split[0] == "acc":
            if split[1][0] == "+":
                self.accumulator += int(split[1][1:])
            else:
                self.accumulator -= int(split[1][1:])
            self.pointer += 1
        else:
            self.pointer += 1

    def tryFix(self):
        self.bootCode = self.originalBootCode.copy()
        p = len(self._mem) - 1
        while self._mem[p] in self._memFix and p > 0:
            p -= 1

        if self.bootCode[self._mem[p]].split()[0] == "jmp":
            self.bootCode[self._mem[p]] = f"nop {self.bootCode[self._mem[p]].split()[1]}"
        else:
            self.bootCode[self._mem[p]] = f"jmp {self.bootCode[self._mem[p]].split()[1]}"
        self._memFix.append(self._mem[p])
        self.pointer = 0
        self.accumulator = 0
        self._mem = []



gc = GameConsole(puzzle_input)
gc.run()
print(f"PartOne: {gc.accumulator}")


gc = GameConsole(puzzle_input, True)
gc.run()
print(f"PartTwo: {gc.accumulator}")
