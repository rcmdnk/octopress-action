#!/usr/bin/env bash

set -e

execute () {
  echo ""
  echo "########################################"
  echo "# $*"
  echo "########################################"
  "$@"
}

execute bundle install
execute rake integrate

if [ "$INPUT_MINIFY" = "1" ] || [ "${INPUT_MINIFY^^}" = "TRUE" ];then
  execute rake generate --trace
else
  execute rake generate['no_minify'] --trace
fi

execute mkdir -p /root/.ssh
execute chmod 700 /root/.ssh
echo "$INPUT_SSH_KEY" > /root/.ssh/id_rsa
execute chmod 600 /root/.ssh/id_rsa
execute echo "$INPUT_KNOWN_HOSTS" > /root/.ssh/known_hosts
execute chmod 600 /root/.ssh/known_hosts

execute git config --global user.email "$INPUT_GIT_USER_EMAIL"
execute git config --global user.name "$INPUT_GIT_USER_NAME"

execute rake deploy["$INPUT_DEPLOY_OPTION"]
