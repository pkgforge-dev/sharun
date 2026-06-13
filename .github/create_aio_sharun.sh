#!/bin/sh
set -e

ARCH="$(uname -m)"

apk add bash file patchelf findutils grep sed coreutils strace which wget

BINS="bash patchelf strace find file grep sed awk \
xargs rm cp ln mv sleep readlink chmod sort tr \
cut mkdir basename dirname uname wget tail"

BINS_PATHS=
for bin in $BINS
    do BINS_PATHS="$BINS_PATHS $(which "$bin")"
done

export WRAPPE="$PWD/wrappe"
wget "https://github.com/VHSgunzo/wrappe/releases/latest/download/wrappe-$ARCH" -O "$WRAPPE"
chmod +x "$WRAPPE"

SHARUN="$PWD/sharun-$ARCH" \
"$PWD/lib4bin" -o -c 22 -g $BINS_PATHS "$WRAPPE"

mv sharun "sharun-$ARCH-aio"
rm -f wrappe*
