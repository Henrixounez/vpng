module vpng

const png_signature = [u8(0x89), 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]

pub fn read(filename string) !PngFile {
	return parse_(filename)
}

pub fn (png PngFile) write(filename string) {
	write_(png, filename)
}

pub fn (mut png PngFile) rotate(degree f64) {
	rotate_(mut png, degree)
}

pub fn (mut png PngFile) mirror_vertical() {
	mirror_vertical_(mut png)
}

pub fn (mut png PngFile) mirror_horizontal() {
	mirror_horizontal_(mut png)
}

pub fn (mut png PngFile) invert() {
	invert_(mut png)
}
