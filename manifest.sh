#!/bin/ash

echo "${TOKEN}" | docker login -u "${USERNAME}" --password-stdin "${REGISTRY}"

docker manifest create \
  "${USERNAME}/${REGISTRY_IMAGE}:${1}" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:amd64" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:armv7" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:arm64"
docker manifest push "${USERNAME}/${REGISTRY_IMAGE}:${1}"

docker manifest create \
  "${USERNAME}/${REGISTRY_IMAGE}:latest" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:amd64" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:armv7" \
  -a "${USERNAME}/${REGISTRY_IMAGE}:arm64"
docker manifest push "${USERNAME}/${REGISTRY_IMAGE}:latest"
