package main

import "fmt"

type File struct {
	name string
	size int
}

func (f File) print(indent int) {
	fmt.Printf("%*d %s\n", indent, f.size, f.name)
}
