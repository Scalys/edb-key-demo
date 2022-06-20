#!/usr/bin/env bash

UTIL_PATH=$(readlink -f "$0")
UTIL_NAME=$(basename "$UTIL_PATH")

err() {
    echo "Error: $@" >& 2
    exit 1
}

usage() {
cat << EOF
$UTIL_NAME KEY FUNCTION CODE
Provision new keys in the clowd for Enclave Device Blueprint

Arguments:
    KEY        key name. In most cases should match an uuid name of the trusted
               application.
               Example: 1f574668-6c89-41b5-b313-4b2d85d63c9d
    FUNCTION   name of the Azure function app. 
               Example: funczz2n5qra5ixe8
    CODE       function code acquired from Azure portal.
               Example: ecnSSC7bumjV8i717d1uZuQritHxKv83vEwszt4iTS4MAzFuS76FkA==
EOF
}

pwd

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    usage
    exit
fi

KEY_NAME="$1"
FUNCTION_APP="$2"
CODE="$3"

if ! [ -n "$KEY_NAME" -a -n "$FUNCTION_APP" -a -n "$CODE" ]; then
    usage
    exit 1
fi


echo "Provisioning $KEY_NAME..."
echo "Function: $FUNCTION_APP"

curl --header "Content-Type: application/json" \
    --request POST \
    --data "{\"key_name\": \"$KEY_NAME\"}" \
    "https://$FUNCTION_APP.azurewebsites.net/api/ProvisionKey/$KEY_NAME?code=$CODE"
if [ $? -ne 0 ]; then
    err "failed to provision"
else
    echo "done"
fi

