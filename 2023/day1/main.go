package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type TokenParser[T any] struct {
	l, r   int
	tokens map[string]T
	text   string
}

func NewTokenParser[T any](tokens map[string]T, text string) *TokenParser[T] {
	return &TokenParser[T]{
		tokens: tokens,
		text:   text,
	}
}

func (p *TokenParser[T]) Next() (*T, error) {
	for p.l < len(p.text) {
		if p.r > len(p.text) {
			p.l++
			p.r = p.l
		}
		window := p.text[p.l:p.r]

		stillPossible := false

		for k, v := range p.tokens {
			if k == window {
				if len(k) == 1 {
					p.l = p.r
				} else {
					p.l = p.r - 1
				}
				return &v, nil
			}

			if len(window) > len(k) {
				continue
			}
			if window == k[:len(window)] {
				stillPossible = true
				continue
			}
		}

		if stillPossible == false {
			p.l++
		} else {
			p.r++
		}
	}

	return nil, fmt.Errorf("end of input")
}

func (p *TokenParser[T]) ToArray() []T {
	var tokens []T

	for {
		token, err := p.Next()
		if err != nil {
			break
		}
		tokens = append(tokens, *token)
	}

	return tokens
}

var tokens = map[string]int{
	"1": 1, "one": 1,
	"2": 2, "two": 2,
	"3": 3, "three": 3,
	"4": 4, "four": 4,
	"5": 5, "five": 5,
	"6": 6, "six": 6,
	"7": 7, "seven": 7,
	"8": 8, "eight": 8,
	"9": 9, "nine": 9,
}

func main() {
	file, err := os.Open("input.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	total := 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		parser := NewTokenParser[int](tokens, scanner.Text())
		numbers := parser.ToArray()

		first, last := numbers[0], numbers[len(numbers)-1]
		combinedStr := strconv.Itoa(first) + strconv.Itoa(last)
		combined, _ := strconv.Atoi(combinedStr)
		total += combined
	}

	println(total)
}
