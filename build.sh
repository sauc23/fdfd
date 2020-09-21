#!/bin/ash

if [[ ${ARCH} != "amd64" ]]; then
  mkdir -p $HOME/.docker/cli-plugins/
  wget -O $HOME/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v${BUILDX_VER}/buildx-v${BUILDX_VER}.linux-amd64
  chmod a+x $HOME/.docker/cli-plugins/docker-buildx
  "echo -e '{\n  \"experimental\": \"enabled\"\n}' | tee $HOME/.docker/config.json"
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  docker buildx create --use --name builder
  docker buildx inspect --bootstrap builder
  docker buildx install
fi

docker build --cache-to=type=local,dest=cache,mode=max --platform linux/${ARCH} -t ${REGISTRY_IMAGE}:${ARCH/\//} .
echo ${TOKEN} | docker login -u ${USERNAME} --password-stdin ${REGISTRY}
docker build --push --cache-from=type=local,src=cache --platform linux/${ARCH} -t ${REGISTRY_IMAGE}:${ARCH/\//} .
