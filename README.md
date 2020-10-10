# **V-PNG**: V PNG Image Processing

## How to use :

Its **simple**, download the module and then you just have to do :
```v
import vpng

png_file := vpng.parse('image.png') or { return }
```

To deal with the different kinds of `Pixel`, (cf: [Pixel Types](###pixel-types)) the prefered method is :
```v
pixel := png_file.pixels[i]
match pixel {
    vpng.Grayscale {

    }
}
```

<br/>

## Methods
| Method | use |
|-|-|
| `.parse(filename string) ?PngFile` | Parses the given `filename` png file and returns an optional `PngFile`. |

<br/>

## Types

### Structure
- `PngFile`, Object returned by the `.parse` function. Contains all useful information about the parsed png file :
    ```v
    pub struct PngFile {
    pub:
        width      int          // Width of image
        height     int          // Height of image
        pixels     []Pixel      // Pixels of image
        pixel_type PixelType    // Pixel type
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

## Todo :
- [ ] Handle all types of colors
    - [ ] Indexed
    - [ ] Grayscale
    - [ ] GrayscaleAlpha
- [ ] Functions to easily manipulate the pixels / image, for example :
    - [ ] Resize
    - [ ] Rotate
    - [ ] Zoom
    - [ ] Slide
    - [ ] Crop
    - [ ] Invert colors
    - [ ] Change colors
    - [ ] ...
- [ ] Write a png file (*Might be hard to have an optimized one*)