# Helpful commands

## Optimize images

```
# preserve file times, print total at end, strip metadata, 4 workers, quality 80
jpegoptim -ptsw4 -m80 *.jpg

# try hardest
optipng -o7 *.png

# or try https://tinypng.com, which seems to do a pretty good job
```

## Create additional video formats

```sh
# `-an` means no audio
ffmpeg -i dog-food-light.mov -an -vf "scale=1280:720" -c:v libx264 -pix_fmt yuv420p output.mp4
ffmpeg -i dog-food-light.mov -an -vf "scale=1280:720" -c:v libvpx-vp9 output.webm
ffmpeg -i dog-food-light.mov -an -vf "scale=1280:720" -c:v libtheora output.ogg
ffmpeg -i dog-food-light.mov -an -vf "fps=10,scale=640:480:flags=lanczos" -c:v gif output.gif
```