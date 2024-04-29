#!/bin/bash
DOCKER_IMAGE_NAME_VERSION="v1"
DOCKER_NODE_IMAGE=node:16
NPM_REGISTRY=http://registry.npm.taobao.org
PWD_DIR=$(cd $(dirname $0); pwd)
echo $PWD_DIR
# docker run  -v $PWD_DIR:$WORKSPACE -w $WORKSPACE $DOCKER_NODE_IMAGE sh -c "npm install --registry=${NPM_REGISTRY} && npm run build"
pnpm i --registry=http://registry.npm.taobao.org  && pnpm build
if [ -n "$1" ] ;then
  DOCKER_IMAGE_NAME_VERSION="$1"
fi
WORKSPACE=/app
echo "DOCKER_IMAGE_NAME_VERSION : $DOCKER_IMAGE_NAME_VERSION"


DOCKER_IMAGE_NAME="aolifu/vue-fabric-editor:${DOCKER_IMAGE_NAME_VERSION}"

docker build -t "${DOCKER_IMAGE_NAME}" .
docker push "${DOCKER_IMAGE_NAME}"

echo "DOCKER_IMAGE_NAME:"$DOCKER_IMAGE_NAME
