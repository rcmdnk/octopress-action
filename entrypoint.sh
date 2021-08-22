#!/usr/bin/env bash

set -e

execute () {
  echo ""
  echo "########################################"
  echo "# $*"
  echo "########################################"
  "$@"
}
generate_option=$1
ssh_key=$2
known_hosts=$3
git_user_email=$4
git_user_name=$5
deploy_option=$6

execute bundle install
execute gem update rake
execute rake integrate

if [ "$generate_option" = "1" ] || [ "${generate_option^^}" = "TRUE" ];then
  execute rake generate --trace
else
  execute rake generate['no_minify'] --trace
fi

execute mkdir -p ~/.ssh
execute chmod 700 ~/.ssh
echo "$ssh_key" > ~/.ssh/id_rsa
execute chmod 600 ~/.ssh/id_rsa
execute echo "$known_hosts" > ~/.ssh/known_hosts
execute chmod 600 ~/.ssh/known_hosts

execute git config --global user.email "$git_user_email"
execute git config --global user.name "$git_user_name"

execute rake deploy["$deploy_option"]
