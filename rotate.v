module vpng

import math

fn normalize_value(val byte) byte {
	if val < 0 {
		return 0
	} else if val > 255 {
		return 255
	} else {
		return val
	}
}

fn rotate_(mut png PngFile, degree f64) {
	angle := degree * math.pi / 180

	i_center_x := png.width / 2
	i_center_y := png.height / 2

	mut output := []Pixel{}

	for i := 0; i < png.height; i++ {
		for j := 0; j < png.width; j++ {
			x := j - i_center_x
			y := i_center_y - i
			f_distance := math.sqrt(x * x + y * y)
			mut f_polar_angle := 0.0
			if x == 0 {
				if y == 0 {
					output << png.pixels[i * png.width + j]
					continue
				} else if y < 0 {
					f_polar_angle = 1.5 * math.pi
				} else {
					f_polar_angle = 0.5 * math.pi
				}
			} else {
				f_polar_angle = math.atan2(y, x)
			}
			f_polar_angle -= angle

			f_true_x := (f_distance * math.cos(f_polar_angle)) + i_center_x
			f_true_y := i_center_y - (f_distance * math.sin(f_polar_angle))

			i_floor_x := math.floor(f_true_x)
			i_floor_y := math.floor(f_true_y)
			i_ceiling_x := math.ceil(f_true_x)
			i_ceiling_y := math.ceil(f_true_y)

			if i_floor_x < 0 || i_ceiling_x < 0 || i_floor_x >= png.width || i_ceiling_x >= png.width || i_floor_y < 0 || i_ceiling_y < 0 || i_floor_y >= png.height || i_ceiling_y >= png.height {
				match png.pixel_type {
					.truecolor {
						output << TrueColor {
							red: 0
							green: 0
							blue: 0
						}
					}
					.truecoloralpha {
						output << TrueColorAlpha {
							red: 0
							green: 0
							blue: 0
							alpha: 0
						}
					}
					else {}
				}
			} else {
				f_delta_x := f_true_x - i_floor_x
				f_delta_y := f_true_y - i_floor_y

				match png.pixel_type {
					.truecolor {
						clr_top_left := png.pixels[i_floor_y * png.width + i_floor_x] as TrueColor
						clr_top_right := png.pixels[i_floor_y * png.width + i_ceiling_x] as TrueColor
						clr_bottom_left := png.pixels[i_ceiling_y * png.width + i_floor_x] as TrueColor
						clr_bottom_right := png.pixels[i_ceiling_y * png.width + i_ceiling_x] as TrueColor

						f_top := TrueColor {
							red: byte((1 - f_delta_x) * clr_top_left.red + f_delta_x * clr_top_right.red)
							green: byte((1 - f_delta_x) * clr_top_left.green + f_delta_x * clr_top_right.green)
							blue: byte((1 - f_delta_x) * clr_top_left.blue + f_delta_x * clr_top_right.blue)
						}
						f_bottom := TrueColor {
							red: byte((1 - f_delta_x) * clr_bottom_left.red + f_delta_x * clr_bottom_right.red)
							green: byte((1 - f_delta_x) * clr_bottom_left.green + f_delta_x * clr_bottom_right.green)
							blue: byte((1 - f_delta_x) * clr_bottom_left.blue + f_delta_x * clr_bottom_right.blue)
						}
						output << TrueColor {
							red: normalize_value(byte((1 - f_delta_y) * f_top.red + f_delta_y * f_bottom.red))
							green: normalize_value(byte((1 - f_delta_y) * f_top.green + f_delta_y * f_bottom.green))
							blue: normalize_value(byte((1 - f_delta_y) * f_top.blue + f_delta_y * f_bottom.blue))
						}
					}
					.truecoloralpha {
						clr_top_left := png.pixels[i_floor_y * png.width + i_floor_x] as TrueColorAlpha
						clr_top_right := png.pixels[i_floor_y * png.width + i_ceiling_x] as TrueColorAlpha
						clr_bottom_left := png.pixels[i_ceiling_y * png.width + i_floor_x] as TrueColorAlpha
						clr_bottom_right := png.pixels[i_ceiling_y * png.width + i_ceiling_x] as TrueColorAlpha

						f_top := TrueColorAlpha {
							red: byte((1 - f_delta_x) * clr_top_left.red + f_delta_x * clr_top_right.red)
							green: byte((1 - f_delta_x) * clr_top_left.green + f_delta_x * clr_top_right.green)
							blue: byte((1 - f_delta_x) * clr_top_left.blue + f_delta_x * clr_top_right.blue)
							alpha: byte((1 - f_delta_x) * clr_top_left.alpha + f_delta_x * clr_top_right.alpha)
						}
						f_bottom := TrueColorAlpha {
							red: byte((1 - f_delta_x) * clr_bottom_left.red + f_delta_x * clr_bottom_right.red)
							green: byte((1 - f_delta_x) * clr_bottom_left.green + f_delta_x * clr_bottom_right.green)
							blue: byte((1 - f_delta_x) * clr_bottom_left.blue + f_delta_x * clr_bottom_right.blue)
							alpha: byte((1 - f_delta_x) * clr_bottom_left.alpha + f_delta_x * clr_bottom_right.alpha)
						}
						output << TrueColorAlpha {
							red: normalize_value(byte((1 - f_delta_y) * f_top.red + f_delta_y * f_bottom.red))
							green: normalize_value(byte((1 - f_delta_y) * f_top.green + f_delta_y * f_bottom.green))
							blue: normalize_value(byte((1 - f_delta_y) * f_top.blue + f_delta_y * f_bottom.blue))
							alpha: normalize_value(byte((1 - f_delta_y) * f_top.alpha + f_delta_y * f_bottom.alpha))
						}
					}
					else {
						TrueColor{
							red: 0
							green: 0
							blue: 0
						}
					}
				}
			}
		}
	}
	png.pixels = output
}