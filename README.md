## Local dev

```
docker build -t custom .

docker run -p 4000:4000 -v $(pwd):/site -e CSS_CACHE_VERSION=latest custom
```

Then open localhost:4000 (0.0.0.0 doesn't work in Safari?)