#!/bin/bash
if [ -z "$1" ]; then { echo "please specify archive output file name (without extension)"; exit 1; }  fi;
tar -czvf "$1".tar.gz --exclude=*.adoc --exclude=*.gitignore $(dirname "$0")/secrets
