FROM alpine:latest@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300

RUN apk --no-cache add dumb-init gettext ca-certificates openssl \
    && wget https://storage.googleapis.com/kubernetes-release/release/$(wget https://storage.googleapis.com/kubernetes-release/release/stable.txt -q -O -)/bin/linux/amd64/kubectl -q -O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl \
    && apk --no-cache del ca-certificates openssl \
    && kubectl

CMD ["kubectl"]
