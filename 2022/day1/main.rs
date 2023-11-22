
const DATA: &str = include_str!("data");

fn main() {
    let mut elves = get_elves_carry_weight(DATA);
    elves.sort();
    println!("Part one: {}", elves[elves.len() - 1]);

    let top_three_sum = elves[elves.len() - 1] + elves[elves.len() - 2] + elves[elves.len() - 3];
    println!("Part two: {}", top_three_sum);

}

fn get_elves_carry_weight(data: &str) -> Vec<isize> {
    let mut out: Vec<isize> = vec![];

    let mut cur_sum = 0;
    for line in data.lines() {
        if line == "" {
            out.push(cur_sum);
            cur_sum = 0;
        } else {
            cur_sum += line.parse::<isize>().unwrap();
        }
    }
    if cur_sum != 0 {
        out.push(cur_sum);
    }

    out
}