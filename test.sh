#!/bin/sh

set -eu

for postfix in "" "-mpich-devel-clang" ".mpich"; do
    MPIRUN=$(which "mpirun${postfix}" ||:)
    MPICXX=$(which "mpicxx${postfix}" ||:)
    if [ -x "${MPIRUN}" ]; then
        break
    fi
done
    
if [ ! -x "${MPIRUN}" ]; then
    echo "ERROR: Can't find mpirun command."
    exit -1
fi

if [ ! -x "${MPICXX}" ]; then
    echo "ERROR: Can't find mpirun command."
    exit -1
fi

echo MPICXX=${MPICXX}
echo MPIRUN=${MPIRUN}

if [ "xtravis" = "x${1:-}" ]; then
    COMPILERS=("clang++-3.5" "g++-5" "g++-4.9")
else
    COMPILERS=("clang++")
fi

for comp in ${COMPILERS[@]}; do
    rm -f ./a.out ||:
    make MPICXX=${MPICXX} CXX=${comp}
    for np in 1 2 3 4; do
        echo ${MPIRUN} -n $np ./a.out
        ${MPIRUN} -n $np ./a.out
    done
done

echo OK.
