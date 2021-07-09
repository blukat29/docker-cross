#!/bin/bash

    #-u $(id -u):$(id -g) \
docker run --rm \
    -v $(pwd):/work \
    -v /etc/passwd:/etc/passwd:ro \
    -it blukat29/cross:buster "$@"
