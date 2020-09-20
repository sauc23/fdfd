#!/bin/sh

docker manifest create \
  ${USERNAME}/${REGISTRY_IMAGE}:latest \
  -a ${USERNAME}/${REGISTRY_IMAGE}:amd64 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm32v7 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm64v8
docker ${USERNAME}/${REGISTRY_IMAGE}:latest

docker manifest create \
  ${USERNAME}/${REGISTRY_IMAGE}:${1} \
  -a ${USERNAME}/${REGISTRY_IMAGE}:amd64 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm32v7 \
  -a ${USERNAME}/${REGISTRY_IMAGE}:arm64v8
docker manifest push ${USERNAME}/${REGISTRY_IMAGE}:${1}
