FROM alpine:latest@sha256:5e604d3358ab7b6b734402ce2e19ddd822a354dc14843f34d36c603521dbb4f9

RUN apk --no-cache add dumb-init gettext ca-certificates openssl \
    && wget https://storage.googleapis.com/kubernetes-release/release/$(wget https://storage.googleapis.com/kubernetes-release/release/stable.txt -q -O -)/bin/linux/amd64/kubectl -q -O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl \
    && apk --no-cache del ca-certificates openssl \
    && kubectl

CMD ["kubectl"]
