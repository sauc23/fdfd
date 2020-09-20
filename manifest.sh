#!/bin/sh

docker manifest create \
  ${USERNAME}/${REGISTRY_IMAGE}:latest \
  -a ${USERNAME}/${REGISTRY_IMAGE}:amd64 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:armv7 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm64
docker manifest push ${USERNAME}/${REGISTRY_IMAGE}:latest

docker manifest create \
  ${USERNAME}/${REGISTRY_IMAGE}:${1} \
  -a ${USERNAME}/${REGISTRY_IMAGE}:amd64 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:armv7 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm64
docker manifest push ${USERNAME}/${REGISTRY_IMAGE}:${1}
