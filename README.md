# **V-PNG**: V PNG Image Processing

## How to use :

Its **simple**, download the module and then you just have to do :
```v
import vpng

png_file := vpng.read("image.png") or { return }
png_file.write("output.png")
```

<br/>
<hr/>
<br/>

## Tips

<br/>

To deal with the different kinds of `Pixel`, (cf: [Pixel Types](###pixel-types)) the prefered method is :
```v
pixel := png_file.pixels[i]
match pixel {
    vpng.Grayscale {
        ...
    }
    vpng.TrueColor {
        ...
    }
    ...
    ...
}
```

<br/>
<hr/>
<br/>

## Methods
| Method | use |
|-|-|
| `read(filename string) ?PngFile` | Parses the given `filename` png file and returns an optional `PngFile`. |
| `(PngFile).write(filename string)` | Writes the given `PngFile` in the `filename` png file.

<br/>

## Types

### Structure
- `PngFile`, Object returned by the `.parse` function. Contains all useful information about the parsed png file :
    ```v
    pub struct PngFile {
        ihdr       IHDR
    pub:
        width      int          // Width of image
        height     int          // Height of image
        pixel_type PixelType    // Pixels type
    pub mut:
        pixels     []Pixel      // Modifiable pixel array
    }
    ```

### Pixel Types
- `PixelType`, Enum for type of pixel possible in the PngFile :
    ```v
    pub enum PixelType {
        indexed
        grayscale
        grayscalealpha
        truecolor
        truecoloralpha
    }
    ```
- `PixelType`, Generic type for the different possible types of pixels : 
    ```v
    pub type Pixel = Grayscale | GrayscaleAlpha | Indexed |     TrueColor | TrueColorAlpha
    ```
- `Pixel`s :
    - Indexed (*Not supported yet*) :
        ```v
        pub struct Indexed {
        pub mut:
            index byte
        }
        ```
    - Grayscale (*Not supported yet*) :
        ```v
        pub struct Grayscale {
        pub mut:
            gray byte
        }
        ```
    - GrayscaleAlpha (*Not supported yet*) :
        ```v
        pub struct GrayscaleAlpha {
        pub mut:
            gray  byte
            alpha byte
        }
        ```
    - TrueColor (RGB) :
        ```v
        pub struct TrueColor {
        pub mut:
            red   byte
            green byte
            blue  byte
        }
        ```
    - TrueColorAlpha (RGBA) :
        ```v
        pub struct TrueColorAlpha {
        pub mut:
            red   byte
            green byte
            blue  byte
            alpha byte
        }
        ```

<br/>
<hr/>
<br/>

## Examples:
- `png-printer.v`: Give it a `.png` file and it will print it for you in the terminal.
- `redline.v`: Give it an input `.png` file and an output `.png` file. It will read the input, add a diagonal red line and write the result on the output file.

### How to compile them from GitHub repository:
```bash
[vpng]$ v examples/png-printer.v -path "..|@vlib|@vmodules"
```

<br/>
<hr/>
<br/>

## Todo :
- [ ] Handle all types of colors
    - [x] Indexed
    - [ ] Grayscale
    - [ ] GrayscaleAlpha
    - [x] TrueColor
    - [x] TrueColorAlpha
- [ ] Functions to easily manipulate the pixels / image, for example :
    - [ ] Resize
    - [x] Mirror
    - [x] Rotate
    - [x] Zoom
    - [ ] Slide
    - [ ] Crop
    - [x] Invert colors
    - [ ] Change colors
    - [ ] ...
- [x] Write a png file (*Might be hard to have an optimized one*)
    - [ ] Optimize it
    - [ ] Filter pixels lines
    - [ ] Group IDAT in chunks
    - [ ] Save metadata
 
