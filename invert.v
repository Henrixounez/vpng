module vpng

fn invert_(mut png PngFile) {
	for i in 0..(png.pixels.len) {
		pix := png.pixels[i]
		match pix {
			TrueColor {
				png.pixels[i] = TrueColor{
					red: 255 - pix.red
					green: 255 - pix.green
					blue: 255 - pix.blue
				}
			}
			TrueColorAlpha {
				png.pixels[i] = TrueColorAlpha{
					red: 255 - pix.red
					green: 255 - pix.green
					blue: 255 - pix.blue
					alpha: pix.alpha
				}
			}
			else {}
		}
	}
}