#!/bin/bash

docker run --rm \
    -v $(pwd):/work \
    -v /etc/passwd:/etc/passwd:ro \
    -u $(id -u):$(id -g) \
    -it blukat29/cross:buster "$@"
