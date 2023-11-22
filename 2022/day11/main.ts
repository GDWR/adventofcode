import {createReadStream} from 'fs';
import {createInterface} from 'readline';


class Monkey {
    items: number[];
    operation: (n: number) => number;
    test: (n: number) => number;
    inspectedItems: number;

    constructor(s: string[]) {
        this.items = [];
        this.inspectedItems = 0;

        let itemsRaw = s[1].split(":")[1];
        for (const i of itemsRaw.split(",")) {
            this.items.push(parseInt(i, 10));
        }

        let evalString = s[2].split("=")[1];
        this.operation = (n: number) => {
            const e = evalString.replace(/old/gi, n.toString());
            const v = eval(e);
            // console.debug("    Worry level is operated on (", e, ") to ", v);
            this.inspectedItems++;
            return v;
        };

        let testDivisibleBy = parseInt(s[3].split(" ")[5], 10);
        let testTrueMonkey = parseInt(s[4].split(" ")[9], 10);
        let testFalseMonkey = parseInt(s[5].split(" ")[9], 10);
        this.test = (n: number) => {
            if (n % testDivisibleBy == 0) {
                // console.debug("    Current worry level is divisible by", testDivisibleBy);
                return testTrueMonkey;
            } else {
                // console.debug("    Current worry level is not divisible by", testDivisibleBy);
                return testFalseMonkey;
            }
        };
    }
}

async function parseMonkeys(fp: string): Promise<Monkey[]> {
    let monkeys = [];
    let buffer = [];
    for await (const line of createInterface(createReadStream(fp))) {
        if (line == "") {
            monkeys.push(new Monkey(buffer));
            buffer = [];
            continue;
        }

        buffer.push(line);
    }
    if (buffer.length != 0) {
        monkeys.push(new Monkey(buffer));
    }

    return monkeys;
}


const monkeys = await parseMonkeys("data");

for (let round = 0; round < 20; round++) {
    for (let monkeyIndex = 0; monkeyIndex < monkeys.length; monkeyIndex++) {
        const monkey = monkeys[monkeyIndex];
        // console.debug("Monkey ", monkeyIndex);
        while (monkey.items.length > 0) {
            let item = monkey.items.shift();
            // console.debug("  Monkey inspects an item with a worry level of ", item);
            item = monkey.operation(item);
            item = Math.floor(item / 3);
            // console.debug("    Monkey gets bored with item. Worry level is divided by 3 to", item);
            const monkeyToThrowTo = monkey.test(item);
            // console.debug("    Item with worry level", item, "is thrown to monkey", monkeyToThrowTo);
            monkeys[monkeyToThrowTo].items.push(item);
        }
    }
}
monkeys.sort((a, b) => b.inspectedItems - a.inspectedItems);
let monkeyBusiness = monkeys.slice(0, 2).reduce((acc, m) => acc * m.inspectedItems, 1);
console.log("Part one:", monkeyBusiness);