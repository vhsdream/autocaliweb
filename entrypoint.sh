#!/bin/bash

#shellcheck disable=SC2086

exec \
  python3  \
    /app/autocaliweb/cps.py \
    -o /dev/stdout \
    "$@"