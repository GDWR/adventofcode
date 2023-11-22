package main

type Filesystem struct {
	root Directory
	cwd  *Directory
}

func newFilesystem() Filesystem {
	root := Directory{
		name:        "",
		files:       make(map[string]File),
		directories: make(map[string]Directory),
	}
	return Filesystem{
		root: root,
		cwd:  &root,
	}
}

func (fs *Filesystem) print() {
	fs.root.print(2)
}

func (fs *Filesystem) handleCommand(command string) {
	if command[:2] == "cd" {
		fs.changeDirectory(command[3:])
	}
}

func (fs *Filesystem) allDirectories() []Directory {
	allDirs := make([]Directory, 1)
	allDirs[0] = fs.root

	for _, dir := range fs.root.directories {
		allDirs = append(allDirs, dir.allDirectories()...)
	}

	return allDirs
}

func (fs *Filesystem) changeDirectory(path string) {

	// Special cases
	switch path {
	case "/":
		fs.cwd = &fs.root
		return
	case ".":
		return
	case "..":
		if fs.cwd.parent != nil {
			fs.cwd = fs.cwd.parent
		}
		return
	default:
		//fs.get
	}
	if path == "/" {
	} else if path == ".." {

	} else {
		for _, directory := range fs.cwd.directories {
			if directory.name == path {
				fs.cwd = &directory
				break
			}
		}
	}
}

func (fs *Filesystem) createRelativeDirectory(name string) {
	fs.cwd.directories[name] = Directory{
		name:        name,
		files:       make(map[string]File),
		directories: make(map[string]Directory),
		parent:      fs.cwd,
	}
}

func (fs *Filesystem) createRelativeFile(name string, size int) {
	fs.cwd.files[name] = File{
		name: name,
		size: size,
	}
}
