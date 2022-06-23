module vpng

// * zlib bindings *
#flag -lz
#include <zlib.h>
struct C.z_stream_s {
	next_in   voidptr
	avail_in  u32
	next_out  voidptr
	avail_out u32
	total_out u64
	zalloc    voidptr
	zfree     voidptr
	opaque    voidptr
}

fn C.inflateInit(&C.z_stream_s)

fn C.inflate(&C.z_stream_s, int)

fn C.inflateEnd(&C.z_stream_s)

fn C.deflateInit(&C.z_stream_s, int)

fn C.deflate(&C.z_stream_s, int)

fn C.deflateEnd(&C.z_stream_s)


// ****
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
