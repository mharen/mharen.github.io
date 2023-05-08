FROM bretfisher/jekyll

RUN apt-get update && apt-get install -y --no-install-recommends libvips-dev libvips-tools libopenjp2-7-dev libpng-dev libwebp-dev liblcms2-dev libheif-dev imagemagick libopenslide-dev

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]