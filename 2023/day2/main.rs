const INPUT: &str = include_str!("input.txt");
const RED_MAX: usize = 12;
const GREEN_MAX: usize = 13;
const BLUE_MAX: usize = 14;

fn main() {
    let games = parse_input(INPUT);

    let part_one: usize = games.iter()
        .map(|g| g.rounds.iter().any(|r| r.red > RED_MAX || r.green > GREEN_MAX || r.blue > BLUE_MAX))
        .enumerate()
        .map(|(i, v)| (1+i) * !v as usize)
        .sum();

    println!("Part one: {}", part_one);

    let part_two: usize = games.iter()
        .map(|game| {
            let r = game.rounds.iter().max_by(|x, y| x.red.cmp(&y.red)).unwrap();
            let g = game.rounds.iter().max_by(|x, y| x.green.cmp(&y.green)).unwrap();
            let b = game.rounds.iter().max_by(|x, y| x.blue.cmp(&y.blue)).unwrap();

            return r.red * g.green * b.blue;
        })
        .sum();

    println!("Part two: {:?}", part_two);
}


fn parse_input(input: &str) -> Vec<Game> {
    let mut games: Vec<Game> = vec![];

    for (i_game, game_raw) in input.lines().enumerate() {
        let Some((_, r)) = game_raw.split_once(":") else {
            panic!("Invalid input");
        };

        let mut game = Game::default();

        for (i_round, round_raw) in r.split(";").enumerate() {
            let mut round = Round::default();

            for cube in round_raw.split(",") {
                let Some((count, colour)) = cube.trim().split_once(" ") else {
                    panic!("Invalid input");
                };

                match colour {
                    "red" => round.red = count.parse::<usize>().unwrap(),
                    "green" => round.green = count.parse::<usize>().unwrap(),
                    "blue" => round.blue = count.parse::<usize>().unwrap(),
                    _ => panic!("Invalid input"),
                }
            }

            game.rounds.push(round);
        }

        games.push(game);
    }

    return games;
}

#[derive(Debug, Default)]
struct Game {
    rounds: Vec<Round>,
}

#[derive(Debug, Default)]
struct Round {
    red: usize,
    green: usize,
    blue: usize,
}