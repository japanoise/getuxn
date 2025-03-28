#!/bin/sh
# Pull all programs, then run updates
OUTDIR="$PWD/roms"
mkdir -p "$OUTDIR"
export OUTDIR

. ./common.sh

progs="drifblim
uxnlin
uxnbal
adelie
bicycle
catclock
cccc
dexe
donsol
left
nasu
nebu
niju
noodle
orca-toy
potato
turye
beetbug
oquonie
tiny-basic
yufo"

num=1
total=$(echo "$progs" | wc -l)

for prog in $progs
do
    (
        report_stage "# Pulling $prog ($num/$total)..."
        cd "$prog" || exit 1
        git pull
        sleeprandom
    )
    num=$((num + 1))
done

report_stage "# Updates pulled, now running build.sh"

./build.sh
