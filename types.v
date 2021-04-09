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
	pixels     []Pixel
}

struct InternalPngFile {
mut:
	ihdr             IHDR
	stride           int
	channels         byte
	idat_chunks      []byte
	raw_bytes        []byte
	unfiltered_bytes []byte
	pixels           []Pixel
	pixel_type       PixelType
}

pub struct IHDR {
mut:
	width              int
	height             int
	bit_depth          byte
	color_type         byte
	compression_method byte
	filter_method      byte
	interlace_method   byte
}

pub struct Indexed {
pub mut:
	index byte
}

pub struct Grayscale {
pub mut:
	gray byte
}

pub struct GrayscaleAlpha {
pub mut:
	gray  byte
	alpha byte
}

pub struct TrueColor {
pub mut:
	red   byte
	green byte
	blue  byte
}

pub struct TrueColorAlpha {
pub mut:
	red   byte
	green byte
	blue  byte
	alpha byte
}
