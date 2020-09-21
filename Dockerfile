FROM node:lts-alpine AS builder
WORKDIR /home/node/
RUN apk add python3 build-base
COPY src .
RUN npm install

FROM node:lts-alpine
WORKDIR /home/node/
COPY --from=builder /home/node/ .
ENTRYPOINT ["/home/node/entrypoint.sh"]
