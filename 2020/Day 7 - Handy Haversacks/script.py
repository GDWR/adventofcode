# Load input
from typing import List, Dict, Tuple, Set

with open("input.txt", "r") as f:
    puzzle_input = [s.rstrip() for s in f.readlines()]


class Bag(object):
    __bags__: Dict[str, "Bag"] = {}

    def __new__(cls, name, *args, **kwargs):
        if bag := cls.__bags__.get(name):
            return bag
        Bag.__bags__[name] = super(Bag, cls).__new__(cls, *args, **kwargs)
        return Bag.__bags__[name]

    def __init__(self, name: str):
        self.name = name
        self._canHold: Set[Bag] = set()
        self.heldBy: Set[Bag] = set()

    def setCanHold(self, canHold: List[str]):
        self._canHold = {Bag(bag) for bag in canHold}

    def _attach(self):
        for bag in self._canHold:
            bag.heldBy.add(self)

    @property
    def canHold(self) -> Set["Bag"]:
        o = [bag for bag in self.heldBy]

        # for bag in self._canHold:
        #     o.append(bag)

        for bag in self.heldBy:
            for b in bag.canHold:
                o.append(b)

        return set(o)

    @classmethod
    def attach_all(cls):
        for bag in cls.__bags__.values():
            bag._attach()


    def __repr__(self):
        return f"<{self.name} Bag>"

# Create Bags
for rule in puzzle_input:
    split = rule.split()
    parent = f"{split.pop(0)} {split.pop(0)}"
    canHold = []
    split = split[2:]
    if split[0] != "no":
        for i in range(0, len(split), 4):
            canHold.append(f"{split[i+1]} {split[i+2]}")
    Bag(parent).setCanHold(canHold)

Bag.attach_all()

find_bag = "shiny gold"

print(f"{find_bag} can be held in {Bag.__bags__[find_bag].canHold}")
print(f"{len(Bag.__bags__[find_bag].canHold)} Bags")