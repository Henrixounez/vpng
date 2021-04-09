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
	mut min := png.width
	if png.height < png.width {
		min = png.height
	}
	for i in 0..min {
		pos := i * png.width + i
		match png.pixel_type {
			.truecolor {
				png.pixels[pos] = vpng.TrueColor {
					255,
					0,
					0,
				}
			}
			.truecoloralpha {
				png.pixels[pos] = vpng.TrueColorAlpha {
					255,
					0,
					0,
					255
				}
			}
			else{}
		}
	}
	png.write(os.args[2])
}