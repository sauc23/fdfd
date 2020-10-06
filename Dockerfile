FROM alpine AS builder
WORKDIR /home/node/
COPY src .
RUN apk add yarn python3 build-base && \
    yarn install --production && \
    rm -r .git .npmignore package*

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
