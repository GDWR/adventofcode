import string
from typing import Optional


def isHex(s: str) -> bool:
    return all(c in string.hexdigits for c in s)


class Passport:
    byr: Optional[str] = None  # (Birth Year)
    iyr: Optional[str] = None  # (Issue Year)
    eyr: Optional[str] = None  # (Expiration Year)
    hgt: Optional[str] = None  # (Height)
    hcl: Optional[str] = None  # (Hair Color)
    ecl: Optional[str] = None  # (Eye Color)
    pid: Optional[str] = None  # (Passport ID)
    cid: Optional[str] = None  # (Country ID)

    @classmethod
    def fromString(cls, string: str) -> "Passport":
        passport = Passport()

        for value in string.split(" "):
            if value:
                key_value = value.split(":")
                passport.__setattr__(key_value[0], key_value[1])
        return passport

    @property
    def BirthYear(self) -> Optional[int]:
        if self.byr:
            if self.byr.isdigit():
                if 1920 <= int(self.byr) <= 2002:
                    return int(self.byr)
            return None

    @property
    def IssueYear(self) -> Optional[int]:
        if self.iyr:
            if self.iyr.isdigit():
                if 2010 <= int(self.iyr) <= 2020:
                    return int(self.iyr)
            return None

    @property
    def ExpirationYear(self) -> Optional[int]:
        if self.eyr:
            if self.eyr.isdigit():
                if 2020 <= int(self.eyr) <= 2030:
                    return int(self.eyr)
            return None

    @property
    def Height(self) -> Optional[str]:
        if self.hgt and self.hgt[0:-2].isdigit():
            if self.hgt.endswith("cm") and 150 <= int(self.hgt[0:-2]) <= 193:
                return self.hgt
            elif self.hgt.endswith("in") and 59 <= int(self.hgt[0:-2]) <= 76:
                return self.hgt

    @property
    def HairColour(self) -> Optional[str]:
        if self.hcl:
            if len(self.hcl) == 7 and self.hcl[0] == "#" and isHex(self.hcl[1:7]):
                return self.hcl
            return None

    @property
    def EyeColour(self) -> Optional[str]:
        if self.ecl:
            if self.ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
                return self.ecl
            return None

    @property
    def PassportId(self) -> Optional[str]:
        if self.pid:
            if self.pid.isdigit() and len(self.pid) == 9:
                return self.pid
            return None

    @property
    def CountryId(self) -> Optional[str]:
        return self.cid

    @property
    def valid(self) -> bool:
        return self.BirthYear is not None and \
               self.EyeColour is not None and \
               self.ExpirationYear is not None and \
               self.HairColour is not None and \
               self.Height is not None and \
               self.IssueYear is not None and \
               self.PassportId is not None


# Load input
with open("input.txt", "r") as f:
    entries = f.read().split("\n")
    puzzleInput = []
    last = 0
    for i, element in enumerate(entries):
        if not element:
            puzzleInput.append(" ".join(entries[last:i]))
            last = i

    print(f"Amount of Passports: {len(puzzleInput)}")

passports = [Passport.fromString(s) for s in puzzleInput]
print(f"Valid passport count is: {len([passport for passport in passports if passport.valid])}")
