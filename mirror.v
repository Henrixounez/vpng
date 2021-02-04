module vpng

fn mirror_vertical_(mut png PngFile) {
	mut output := []Pixel{}

	for y in 0..(png.height) {
		for x in 0..(png.width) {
			output << png.pixels[y * png.width + (png.width - 1 - x)]
		}
	}
	png.pixels = output
}

fn mirror_horizontal_(mut png PngFile) {
	mut output := []Pixel{}

	for y in 0..(png.height) {
		for x in 0..(png.width) {
			output << png.pixels[((png.width - 1) - y) * png.width + x]
		}
	}
	png.pixels = output
}