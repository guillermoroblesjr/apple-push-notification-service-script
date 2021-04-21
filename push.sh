#!/bin/bash

# Verify that your certificate is valid
# E.g. 
# $ ./push.sh verify
function verify() {
  local CONFIG="./config.json"

  local CERTIFICATE_FILE_NAME=($(jq -r '.CERTIFICATE_FILE_NAME' $CONFIG))
  local APNS_HOST_NAME=($(jq -r '.APNS_HOST_NAME' $CONFIG))

  openssl s_client -connect "${APNS_HOST_NAME}":443 -cert "${CERTIFICATE_FILE_NAME}" 
}

# Send a push notification
# E.g.
# $ ./push.sh send
function send() {
  local CONFIG="./config.json"

  local DATA=($(jq -r '.DATA' $CONFIG))
  local CERTIFICATE_FILE_NAME=($(jq -r '.CERTIFICATE_FILE_NAME' $CONFIG))
  local CERTIFICATE_KEY_FILE_NAME=($(jq -r '.CERTIFICATE_KEY_FILE_NAME' $CONFIG))
  local TOPIC=($(jq -r '.TOPIC' $CONFIG))
  local APNS_HOST_NAME=($(jq -r '.APNS_HOST_NAME' $CONFIG))
  local DEVICE_TOKEN=($(jq -r '.DEVICE_TOKEN' $CONFIG))

  # Allows you to pass in variables. Optional, better to use the config.json file.
  # E.g.
  # $ ./push.sh send --DATA=./payload2.json
  while [ $# -gt 0 ]; do
    case "$1" in
      --CONFIG=*)
        local CONFIG="${1#*=}"
        ;;
      --DATA=*)
        local DATA="${1#*=}"
        ;;
      --CERTIFICATE_FILE_NAME=*)
        local CERTIFICATE_FILE_NAME="${1#*=}"
        ;;
      --CERTIFICATE_KEY_FILE_NAME=*)
        local CERTIFICATE_KEY_FILE_NAME="${1#*=}"
        ;;
      --TOPIC=*)
        local TOPIC="${1#*=}"
        ;;
      --APNS_HOST_NAME=*)
        local APNS_HOST_NAME="${1#*=}"
        ;;
      --DEVICE_TOKEN=*)
        local DEVICE_TOKEN="${1#*=}"
        ;;
      *)
        printf "***************************\n"
        printf "* Error: Invalid argument.*\n"
        printf "***************************\n"
        exit 1
    esac
    shift
  done

  # save the JSON payload as a variable
  local DATA=$(cat < $DATA)

  echo "CERTIFICATE_FILE_NAME: ${CERTIFICATE_FILE_NAME}"
  echo "CERTIFICATE_KEY_FILE_NAME: ${CERTIFICATE_KEY_FILE_NAME}"
  echo "TOPIC: ${TOPIC}"
  echo "APNS_HOST_NAME: ${APNS_HOST_NAME}"
  echo "DEVICE_TOKEN: ${DEVICE_TOKEN}"
  echo "DATA: ${DATA}"
  echo " "

  curl -v --header "apns-topic: ${TOPIC}" \
  --header "apns-push-type: alert" \
  --cert "${CERTIFICATE_FILE_NAME}" \
  --key-type PEM \
  --data "${DATA}" \
  --http2  "https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}"
}

"$@"