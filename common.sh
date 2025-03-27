#!/bin/sh
report_stage() {
    printf "\n%s\n\n" "$1"
}

sleeprandom() {
    # sleep between 5-50 seconds
    sleep $(($(shuf -i 1-10 -n 1) * 5))
}

clone_if_nexist() {
    dir="$1"
    repo="git@git.sr.ht:~rabbits/$1"
    if [ -n "$2" ]
    then
        repo="$2"
    fi

    if ! [ -d "$1" ]
    then
        report_stage "# cloning $repo to $dir"
        # sleep a bit to avoid hammering Drew's servers, remove this
        # if you're a cowboy and like getting banned/rate-limited
        sleeprandom
        git clone "$repo" "$dir"
    fi
}

make_install() {
    srcdir="$1"
    (
        report_stage "# building $1"
        cd "$srcdir" || exit 1
        make DIR="$OUTDIR" || exit 1
        cp bin/*.rom "$OUTDIR"
    )
}

maybe_parallel() {
    cmd="$1"
    args="$2"

    if command -v parallel
    then
        echo "$args" | parallel "$cmd"
    elif command -v parallel-moreutils
    then
        # shellcheck disable=SC2086
        parallel-moreutils "$cmd" -- $args
    else
        for arg in $args
        do
            "$cmd" "$arg"
        done
    fi
}
