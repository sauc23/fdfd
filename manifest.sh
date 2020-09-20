#!/bin/ash

echo "${TOKEN}" | docker login -u "${USERNAME}" --password-stdin ${REGISTRY}

docker manifest create \
  "${REGISTRY_IMAGE}:${1}" \
  -a "${REGISTRY_IMAGE}:amd64" \
  -a "${REGISTRY_IMAGE}/:armv7" \
  -a "${REGISTRY_IMAGE}:arm64"
docker manifest push "${REGISTRY_IMAGE}:${1}"

docker manifest create \
  "${REGISTRY_IMAGE}:latest" \
  -a "${REGISTRY_IMAGE}:amd64" \
  -a "${REGISTRY_IMAGE}:armv7" \
  -a "${REGISTRY_IMAGE}:arm64"
docker manifest push "${REGISTRY_IMAGE}:latest"
