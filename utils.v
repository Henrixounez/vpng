module vpng

fn byte_to_int(bytes []byte) int {
	mut res := 0
	for i in 0 .. bytes.len {
		res += bytes[bytes.len - (i + 1)] << ((i) * 8)
	}
	return res
}

fn int_to_bytes(nb int) []byte {
	return [byte((nb >> 24) & 0xFF), byte((nb >> 16) & 0xFF), byte((nb >> 8) & 0xFF), byte(nb & 0xFF)]
}

fn subarray(arr []byte, start int, end int) []byte {
	mut res := []byte{len: end - start}
	for i in 0 .. (end - start) {
		res[i] = arr[start + i]
	}
	return res
}
