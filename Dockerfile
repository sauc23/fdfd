FROM alpine AS builder

ARG VERSION

WORKDIR /home/node/
RUN sed -i 's/https\:\/\/dl-cdn.alpinelinux.org/https\:\/\/ewr.edge.kernel.org/g' /etc/apk/repositories && \
    apk add git npm python3 build-base && \
    git clone --depth 1 --branch ${VERSION} https://github.com/webtorrent/bittorrent-tracker.git . && \
    rm -rf .git \
           .github \
           .gitignore \
           .npmignore \
           examples \
           img \
           test \
           tools \
           .travis.yml \
           *.md \
           LICENSE && \
    npm install --production && \
    npm cache clean --force
COPY entrypoint.sh .

FROM alpine
ENV HTTP=1 \
    UDP=1 \
    WS=1 \
    QUIET=1 \
    SILENT=0 \
    TRUST_PROXY=0 \
    STATS=1 \
    INTERVAL=600000 \
    PORT=8000
RUN apk add npm
WORKDIR /home/node/
COPY --from=builder /home/node/ .
ENTRYPOINT ["/home/node/entrypoint.sh"]
