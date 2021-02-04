module vpng

pub fn read(filename string) ?PngFile {
	return parse_(filename)
}
pub fn (png PngFile)write(filename string) {
	write_(png, filename)
}