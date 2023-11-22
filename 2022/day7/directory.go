package main

import "fmt"

type Directory struct {
	name        string
	files       map[string]File
	directories map[string]Directory
	parent      *Directory
}

func (d *Directory) addFile(file File) {
	d.files[file.name] = file
}

func (d *Directory) addDirectory(directory Directory) {
	d.directories[directory.name] = directory
}

func (d *Directory) getSize() int {
	total := 0

	for _, file := range d.files {
		total += file.size
	}

	for _, dir := range d.directories {
		total += dir.getSize()
	}

	return total
}

func (d *Directory) print(indent int) {
	fmt.Printf("%*s/\n", indent, d.name)

	for _, file := range d.files {
		file.print(indent + 4)
	}

	for _, directory := range d.directories {
		directory.print(indent + 4)
	}
}

func (d *Directory) allDirectories() []Directory {
	allDirs := make([]Directory, 1)
	allDirs[0] = *d

	for _, dir := range d.directories {
		allDirs = append(allDirs, dir.allDirectories()...)
	}

	return allDirs
}
