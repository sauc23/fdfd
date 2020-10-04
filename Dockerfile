FROM alpine AS builder
WORKDIR /home/node/
COPY src .
RUN apk add yarn python3 build-base && \
    yarn install --production && \
    rm -r .git .npmignore package*

FROM alpine
RUN apk add npm
WORKDIR /home/node/
COPY --from=builder /home/node/ .
ENTRYPOINT ["/home/node/entrypoint.sh"]
