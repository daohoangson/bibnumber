#!/bin/sh

set -e

_tag="bibnumber-`date +%s`"
_tmpPath="/tmp/$_tag"

if [ -d $_tmpPath ]; then
  rm -rf $_tmpPath
fi
mkdir $_tmpPath

{ \
  echo 'FROM buildpack-deps'; \
  echo 'RUN apt-get update'; \
  echo 'RUN apt-get install -y \'; \
  echo '  libtesseract-dev tesseract-ocr-eng \'; \
  echo '  libopencv-dev \'; \
  echo '  libboost-filesystem-dev \'; \
  echo '  libleptonica-dev'; \
} >"/tmp/$_tag/Dockerfile"

docker build -t $_tag $_tmpPath

exec docker run --rm -it \
  -v "$PWD:/src" -w /src \
  $_tag bash
