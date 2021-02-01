#!/bin/bash

case "$1" in
  *.md)
    pandoc -s -f gfm+pipe_tables -t man "$1" | groff -T utf8 -man > /tmp/less.$$
    if [ -s /tmp/less.$$ ]; then
        echo /tmp/less.$$
    else
        rm -f /tmp/less.$$
    fi
    ;;
esac
