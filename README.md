# rgd
Game scripts running on RGD (an RGSS runtime)

## Notes

### How to use `bitmap.process_color`?

```rb
bitmap.process_color { |arr| ... }
```

`arr` is a ColorArray, which is `Color[]` starting from the top-left corner,
which means `arr[0]` is `bitmap.get_pixel(0, 0)`.

`ColorArray` has `[], []=, size, save_data, load_data` methods. Note that it is not a
subclass of `Array`.

```rb
buffer = "\0" * 4
bitmap.process_color { |arr| arr.save_data(buffer, 1) }
buffer.unpack 'C*' #=> [0x56, 0x34, 0x12, 0x78]
bitmap.get_pixel(0, 0) #=> Color(0x12, 0x34, 0x56, 0x78)
```

Saves N colors into buffer (a string). For each color, it saves 4 bytes
in the order of `bgra`.

### How to make graphics smooth when `resize_window`?

```rb
Graphics.filter = 1
Graphics.resize_window(Graphics.width * 2, Graphics.height * 2)
```

`Graphics.filter` is 0 by default, meaning that it uses nearest insert algorithm
to make the graphics look very pixel. You can change it to 1 so that it will
use the same way as the original RGSS does, which looks a bit blur.
