#!/bin/sh

source $(dirname "$0")/ssl-functions.sh
cat $(pub_file $1).crt
