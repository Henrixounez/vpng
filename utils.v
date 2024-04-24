module vpng

fn byte_to_int(bytes []u8) int {
	mut res := 0
	for i in 0 .. bytes.len {
		res += bytes[bytes.len - (i + 1)] << (i * 8)
	}
	return res
}

fn int_to_bytes(nb int) []u8 {
	return [u8((nb >> 24) & 0xFF), u8((nb >> 16) & 0xFF), u8((nb >> 8) & 0xFF), u8(nb & 0xFF)]
}
