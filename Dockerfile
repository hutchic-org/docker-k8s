FROM alpine:latest@sha256:e7d88de73db3d3fd9b2d63aa7f447a10fd0220b7cbf39803c803f2af9ba256b3

RUN apk --no-cache add dumb-init gettext ca-certificates openssl \
    && wget https://storage.googleapis.com/kubernetes-release/release/$(wget https://storage.googleapis.com/kubernetes-release/release/stable.txt -q -O -)/bin/linux/amd64/kubectl -q -O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl \
    && apk --no-cache del ca-certificates openssl

CMD ["kubectl"]
