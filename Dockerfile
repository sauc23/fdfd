FROM node:lts-alpine AS builder
WORKDIR /home/node/
COPY . .
RUN npm install

FROM node:lts-alpine
WORKDIR /home/node/
COPY --from=builder /home/node/ .
ENTRYPOINT ["/home/node/entrypoint.sh"]
