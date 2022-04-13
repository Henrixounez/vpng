import vpng

mut png_file := vpng.read("v-logo-small.png") or { return }
png_file.zoom(10)
png_file.write("v-logo-big.png")
