module vpng

pub enum PixelType {
	indexed
	grayscale
	grayscalealpha
	truecolor
	truecoloralpha
}

pub type Pixel = Grayscale | GrayscaleAlpha | Indexed | TrueColor | TrueColorAlpha

pub struct PngFile {
	ihdr       IHDR
pub:
	width      int
	height     int
	pixel_type PixelType
pub mut:
	palette    []TrueColor
	pixels     []Pixel
}

struct InternalPngFile {
mut:
	ihdr             IHDR
	stride           int
	channels         u8
	idat_chunks      []u8
	raw_bytes        []u8
	unfiltered_bytes []u8
	plte             []u8
	pixels           []Pixel
	pixel_type       PixelType
}

pub struct IHDR {
mut:
	width              int
	height             int
	bit_depth          u8
	color_type         u8
	compression_method u8
	filter_method      u8
	interlace_method   u8
}

pub struct Indexed {
pub mut:
	index u8
}

pub struct Grayscale {
pub mut:
	gray u8
}

pub struct GrayscaleAlpha {
pub mut:
	gray  u8
	alpha u8
}

pub struct TrueColor {
pub mut:
	red   u8
	green u8
	blue  u8
}

pub struct TrueColorAlpha {
pub mut:
	red   u8
	green u8
	blue  u8
	alpha u8
}
