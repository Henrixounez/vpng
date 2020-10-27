module vpng

pub fn read(filename string) ?PngFile {
	return parse_(filename)
}

pub fn write(png PngFile, filename string) {
	write_(png, filename)
}