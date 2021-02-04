module main

import vpng
import os

// RedLine
// Adds a diagonal red line on a picture and saves it to an output file

fn main() {
	if os.args.len != 3 {
		println('Missing filename')
		println('./redline input.png output.png')
		return
	}
	mut png := vpng.read(os.args[1]) or {
		return
	}
	for i in 0..png.width {
		png.pixels[i * png.width + i] = vpng.TrueColorAlpha {
			255,
			0,
			0,
			255
		}
	}
	png.write(os.args[2])
}