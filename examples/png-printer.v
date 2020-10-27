module main

import vpng
import os
import term

// Png Printer
// Read and print a png file on the terminal

fn pixel_print_hd(x int, y int, png vpng.PngFile) {
	if x >= png.width || y >= png.height {
		return
	}
	top_pixel := png.pixels[y * png.width + x]
	mut top_str := ""
	match top_pixel {
		vpng.TrueColor {
			top_str = term.rgb(top_pixel.red, top_pixel.green, top_pixel.blue, '▀')
		}
		vpng.TrueColorAlpha {
			top_str = term.rgb(top_pixel.red, top_pixel.green, top_pixel.blue, '▀')
		}
		else {
			""
		}
	}
	if y + 1 >= png.height {
		print(top_str)
		return
	}
	bot_pixel := png.pixels[(y + 1) * png.width + x]
	mut bot_str := ""
	match bot_pixel {
		vpng.TrueColor {
			bot_str = term.bg_rgb(bot_pixel.red, bot_pixel.green, bot_pixel.blue, top_str)
		}
		vpng.TrueColorAlpha {
			bot_str = term.bg_rgb(bot_pixel.red, bot_pixel.green, bot_pixel.blue, top_str)
		}
		else {
			""
		}
	}
	print(bot_str)
}

fn hi_res_print(png vpng.PngFile) {
	mut x := 0
	mut y := 0
	
	for y < png.height {
		x = 0
		for x < png.width {
			pixel_print_hd(x, y, png)
			x++
		}
		println('')
		y += 2
	}
}

fn main() {
	if os.args.len != 2 {
		println('Missing filename')
		return
	}
	filename := os.args[1]
	png := vpng.read(filename) or {
		return
	}
	hi_res_print(png)
}