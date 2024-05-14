#!/bin/bash

docker build -t hollywood:latest . && docker run --rm -it hollywood
