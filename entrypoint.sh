#!/bin/bash

echo "Trying to copy git credentials file"

cd /tmp
git init

set -x

git config --global user.email ${GITHUB_USER_EMAIL}
git config --global user.name ${GITHUB_USERNAME}
git config --global user.password ${GITHUB_PASSWORD}

echo http://${GITHUB_USERNAME}:${GITHUB_PASSWORD}@github.com > /root/.git-credentials

cp .gitconfig /root/.gitconfig

git config credential.helper --file .git-credentials

sed -i -e "s/\${GITHUB_USERNAME}/${GITHUB_USERNAME}/" /root/.m2/settings.xml
sed -i -e "s/\${GITHUB_USERNAME}/${GITHUB_PASSWORD}/" /root/.m2/settings.xml

COMMAND=$1
if [[ -z "${2}" || -z "${3}" || -z "${4}" ]]; then
  echo "One or more variables are not defined, will only run command"
else
  DOCKER_USERNAME=$2
  DOCKER_PASSWORD=$3
  DOCKER_REGISTRY=$4
  echo "Running docker login into ${DOCKER_REGISTRY}"
  echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin ${DOCKER_REGISTRY}
fi

echo "Running command"
${COMMAND}