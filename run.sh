#!/bin/bash
docker run -it -v ${PWD}:/work -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/groups:/etc/groups:ro -v /etc/passwd:/etc/passwd:ro -e DISPLAY=:0 -w /work --user $(id -u):$(id -g) --rm verilator $*
