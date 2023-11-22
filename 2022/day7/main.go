package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	readFile, err := os.Open("data")
	if err != nil {
		panic(err)
	}

	fileSystem := newFilesystem()
	fileScanner := bufio.NewScanner(readFile)
	for fileScanner.Scan() {
		row := fileScanner.Text()

		if row[0] == '$' {
			fileSystem.handleCommand(row[2:])
		} else {
			split := strings.Split(row, " ")
			sizeOrDir := split[0]
			name := split[1]

			if sizeOrDir == "dir" {
				fileSystem.createRelativeDirectory(name)
			} else {
				size, err := strconv.Atoi(sizeOrDir)
				if err != nil {
					panic("Unable to parse int")
				}
				fileSystem.createRelativeFile(name, size)
			}
		}
	}

	{
		total := 0

		for _, dir := range fileSystem.allDirectories() {
			size := dir.getSize()
			if size <= 100_000 {
				total += size
			}
		}

		fmt.Printf("\nPart one: %d\n", total)
	}

	{
		spaceFree := 70_000_000 - fileSystem.root.getSize()
		spaceRequired := 30000000 - spaceFree
		fmt.Printf("\n\nfree space = %d\n", spaceFree)
		fmt.Printf("space required = %d\n", spaceRequired)

		smallestSize := 0
		var smallestDir *Directory = nil

		for _, dir := range fileSystem.allDirectories() {
			size := dir.getSize()
			if size >= spaceRequired && (smallestDir == nil || smallestSize > size) {
				smallestSize = size
				smallestDir = &dir
			}
		}

		fmt.Printf("directory = %s\n", smallestDir.name)
		fmt.Printf("size = %d\n", smallestSize)
	}

}
