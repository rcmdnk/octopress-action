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

execute mkdir -p ~/.ssh
execute cmod 700 ~/.ssh
echo "$INPUT_SSH_KEY" > ~/.ssh/id_rsa
execute chmod 700 ~/.ssh/id_rsa
execute echo "$INPUT_KNOWN_HOSTS" > ~/.ssh/known_hosts
execute chmod 700 ~/.ssh/known_hosts

execute git config --global user.email "$INPUT_GIT_USER_EMAIL"
execute git config --global user.name "$INPUT_GIT_USE_NAME"

execute rake deploy["$INPUT_DEPLOY_OPTION"]
