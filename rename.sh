#!/bin/bash

# https://stackoverflow.com/a/2013573/205696
EXTENSION_FROM=${2:-".js"}
EXTENSION_TO=${3:-".mjs"}

if [ ! -z $1 -a -d $1 ]; then
  echo "find *$2 in $1"
  echo "change $2 to $3"
  FIND="*$EXTENSION_FROM"
  EXECUTE="s/${EXTENSION_FROM/\./\\.}\$/${EXTENSION_TO/\./\\.}/i"

  CMD="find $1 -name $FIND -exec rename -v '$EXECUTE' {} \;"

  echo "Will execute: $CMD"
  eval $CMD
else
  echo "$1 not found"
  echo "Usage: rename.sh directory [from] [to]"
fi