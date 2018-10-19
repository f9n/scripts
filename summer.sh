#!/usr/bin/env bash
##########################
### Install
### Usage
# $ summer <git_username>
# Ok
##########################


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

CONFIG_FILE_PATH="$HOME/.summer"

declare -A UsersAndEmails

function set_git_username {
  local username=$1
  git config --global user.name $username
}

function set_git_email {
  local email=$1
  git config --global user.email $email
}

function check_config_file {
  local tmp_username=
  local tmp_email=
  if [ ! -e "${CONFIG_FILE_PATH}" ]; then
    echo -e "${RED}You don't have ${CONFIG_FILE_PATH} file${NC}"
    tmp_username=$(git config --global user.name)
    tmp_email=$(git config --global user.email)
    echo -e "${tmp_username} ${tmp_email}" > $CONFIG_FILE_PATH
    echo -e "${GREEN}We created your .summerrc file${NC}"
    exit 1
  fi
}

function read_users_and_emails {
  local tmp_username=
  local tmp_email=
  while read line; do
    tmp_username=$(echo ${line} | cut -d' ' -f1)
    tmp_email=$(echo ${line} | cut -d' ' -f2)
    UsersAndEmails[$tmp_username]=$tmp_email
  done < ${CONFIG_FILE_PATH}
}

function summer_main {
  if [ "$#" -lt 1 ]; then
    echo -e "${RED}Please entry some argument${NC}"
    exit 1
  fi

  local username=$1

  check_config_file
  read_users_and_emails

  local email=${UsersAndEmails[$username]}
  if [[ $email == "" ]]; then
    echo -e "${RED}I'm sorry, there isn't any username${NC}"
    exit 1
  fi

  set_git_username $username
  set_git_email $email
  echo -e "${GREEN}Ok${NC}"
}

summer_main $@
