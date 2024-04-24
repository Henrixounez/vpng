module vpng

// Implementation of https://www.w3.org/TR/PNG-CRCAppendix.html

pub struct CRC {
mut:
	crc_table          []u64 = []u64{len: 256}
	crc_table_computed int
}

fn (mut cs CRC) make_crc_table() {
	mut c := u64(0)
	mut n := int(0)
	mut k := int(0)

	for n = 0; n < 256; n++ {
		c = u64(n)
		for k = 0; k < 8; k++ {
			if c & 1 != 0 {
				c = u64(i64(0xedb88320) ^ i64(c >> 1))
			} else {
				c = c >> 1
			}
		}
		cs.crc_table[n] = c
	}
	cs.crc_table_computed = 1
}

fn (mut cs CRC) update_crc(crc u64, buf []u8, len int) u64 {
	mut c := u64(crc)
	mut n := int(0)

	if cs.crc_table_computed == 0 {
		cs.make_crc_table()
	}
	for n = 0; n < len; n++ {
		c = cs.crc_table[(c ^ buf[n]) & 0xff] ^ (c >> 8)
	}
	return c
}

pub fn (mut cs CRC) crc(buf []u8, len int) u64 {
	return cs.update_crc(u64(0xffffffff), buf, len) ^ u64(0xffffffff)
}
