#!/bin/ash

apk add curl jq

RUNNER_ARCH=$(arch)
RUNNER_ARCH=${RUNNER_ARCH/x86_/amd}
RUNNER_ARCH=${RUNNER_ARCH/aarch/arm}
BUILDX_VER=$(curl -ks https://api.github.com/repos/docker/buildx/releases/latest | jq -r '.name')
mkdir -p "$HOME/.docker/cli-plugins/"
wget -O "$HOME/.docker/cli-plugins/docker-buildx" "https://github.com/docker/buildx/releases/download/${BUILDX_VER}/buildx-${BUILDX_VER}.linux-${RUNNER_ARCH}"
chmod a+x "$HOME/.docker/cli-plugins/docker-buildx"
echo -e '{\n  "experimental": "enabled"\n}' | tee "$HOME/.docker/config.json"

if [[ ${RUNNER_ARCH} != ${ARCH} ]]; then
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi

docker buildx create --use --name builder
docker buildx inspect --bootstrap builder
docker buildx install

docker buildx build --cache-to=type=local,dest=cache,mode=max --build-arg VERSION --platform "linux/${ARCH}" -t "${REGISTRY_IMAGE}:${ARCH/\//}" .
echo "${TOKEN}" | docker login -u "${USERNAME}" --password-stdin ${REGISTRY}
docker buildx build --push --cache-from=type=local,src=cache --build-arg VERSION --platform "linux/${ARCH}" -t "${REGISTRY_IMAGE}:${ARCH/\//}" .
