#!/bin/sh
# Install misbehaving programs
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

case "$1" in
    beetbug )
        (
            report_stage "# building $1"
            cd "$1" || exit 1
            uxnasm src/beetbug.tal bin/beetbug.rom || exit 1
            cp bin/*.rom "$OUTDIR"
        );;
    oquonie )
        (
            report_stage "# building $1"
            cd "$1" || exit 1
            make DIR="$OUTDIR" bin/oquonie.rom || exit 1
            cp bin/oquonie.rom "$OUTDIR"
        );;
    yufo )
        (
            report_stage "# building $1"
            cd "$1" || exit 1
            mkdir -p bin
            uxnasm src/main.tal bin/yufo.rom || exit 1
            cp bin/*.rom "$OUTDIR"
        )
        ;;
    tiny-basic )
        (
            report_stage "# building $1"
            cd "$1" || exit 1
            mkdir -p bin
            uxnasm src/basic.tal bin/basic.rom || exit 1
            cp bin/*.rom "$OUTDIR"
        )
        ;;
    * )
        echo "$0: don't know how to build $1"
        ;;
esac
