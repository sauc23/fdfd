#!/bin/ash

RUNNER_ARCH=$(arch)
RUNNER_ARCH=${RUNNER_ARCH/x86_/amd}
RUNNER_ARCH=${RUNNER_ARCH/aarch/arm}
BUILDX_VER=$(curl -ks https://api.github.com/repos/docker/buildx/releases/latest | jq -r '.name')
mkdir -p "$HOME/.docker/cli-plugins/"
wget -O "$HOME/.docker/cli-plugins/docker-buildx" "https://github.com/docker/buildx/releases/download/${BUILDX_VER}/buildx-${BUILDX_VER}.linux-${RUNNER_ARCH}"
chmod a+x "$HOME/.docker/cli-plugins/docker-buildx"
echo -e '{\n  "experimental": "enabled"\n}' | tee "$HOME/.docker/config.json"

echo "${TOKEN}" | docker login -u "${USERNAME}" --password-stdin ${REGISTRY}

docker buildx imagetools create \
  -t "${REGISTRY_IMAGE}:${1}" \
  "${REGISTRY_IMAGE}:amd64" \
  "${REGISTRY_IMAGE}:armv7" \
  "${REGISTRY_IMAGE}:arm64"
docker buildx imagetools create \
  -t "${REGISTRY_IMAGE}:latest" \
  "${REGISTRY_IMAGE}:amd64" \
  "${REGISTRY_IMAGE}:armv7" \
  "${REGISTRY_IMAGE}:arm64"

docker buildx imagetools create \
  -t "${REGISTRY_IMAGE2}:${1}" \
  "${REGISTRY_IMAGE}:amd64" \
  "${REGISTRY_IMAGE}:armv7" \
  "${REGISTRY_IMAGE}:arm64"
docker buildx imagetools create \
  -t "${REGISTRY_IMAGE2}:latest" \
  "${REGISTRY_IMAGE}:amd64" \
  "${REGISTRY_IMAGE}:armv7" \
  "${REGISTRY_IMAGE}:arm64"
