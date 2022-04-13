module vpng

fn zoom_(mut old_png PngFile,png_scale int) {
	png_width:=old_png.width
	png_height:=old_png.height

	mut png:=PngFile{
		ihdr: IHDR{
			width: png_width
			height: png_height
			bit_depth: 8
			color_type: 6
			compression_method: 0
			filter_method: 0
			interlace_method: 0
		},
		width: png_width*png_scale
		height: png_height*png_scale
		pixel_type: PixelType.truecoloralpha
		pixels: []
	}

	for i:=0; i<png_height; i++{
		for l:=0; l<png_scale; l++{
			for k:=0; k<png_width; k++{
				for j:=0; j<png_scale; j++{
					pix:=old_png.pixels[(i*png_width+k)]
					match pix {
						TrueColorAlpha {
							png.pixels << TrueColorAlpha {
								red: pix.red
								green: pix.green
								blue: pix.blue
								alpha: pix.alpha
							}
						}
						TrueColor {
							png.pixels << TrueColorAlpha {
								red: pix.red
								green: pix.green
								blue: pix.blue,
								alpha: 255
							}
						} else {}
					}
				}
			}
		}
	}
	old_png=png
}