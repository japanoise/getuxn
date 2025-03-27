#!/bin/sh
# build the toolchain, programs, etc. and drop the results in ../roms
OUTDIR="$PWD/roms"
mkdir -p "$OUTDIR"
export OUTDIR

. ./common.sh

# Toolchain build; has to be done linearly so we have dependencies
# (maybe just for drifblim, but better safe than sorry)

for prog in drifblim uxnlin uxnbal
do
    ./clone_install.sh "$prog"
done

# List of well-behaved programs
progs="adelie
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
turye"

# build all well-behaved programs, in parallel if supported
maybe_parallel ./clone_install.sh "$progs"

# List of misbehaving programs
progs="beetbug
oquonie
tiny-basic
yufo"

# build all misbehaving programs, in parallel if supported
maybe_parallel ./other_install.sh "$progs"
