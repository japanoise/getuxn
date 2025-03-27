#!/bin/sh
. ./common.sh

if [ -z "$OUTDIR" ]
then
    echo "$0: please set & export OUTDIR" >&2
    exit 1
fi

if [ -z "$1" ]
then
    echo "$0: clone and make-install what?" >&2
    exit 1
fi

clone_if_nexist "$1"
make_install "$1"
