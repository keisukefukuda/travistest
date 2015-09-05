#!/bin/sh

set -eu
MPICXX=$(which mpicxx ||:)
if [ ! -x "${MPICXX}" ]; then MPICXX=$(which mpicxx-mpich-devel-clang ||:); fi

for cand in mpirun mpirun-mpich-devel-clang mpirun.mpich; do
    MPIRUN=$(which $cand ||:)
    if [ -x "${MPIRUN}" ]; then
        break
    fi
done
    
if [ ! -x "${MPIRUN}" ]; then
    echo "ERROR: Can't find mpirun command."
    exit -1
fi

date

echo MPICXX=$MPICXX
echo MPIRUN=$MPIRUN

for CXX in g++-4.9 g++-5 clang++-3.5 clang++ ; do
    echo "----------------------"
    CXX=$(which $CXX ||:)
    if [ -x "${CXX}" ]; then
        rm ./a.out
        make MPICXX=${MPICXX}

        for np in 1 2 3 4; do
            echo ${MPIRUN} -n $np ./a.out
            ${MPIRUN} -n $np ./a.out
        done
    else
        echo "Can't find ${CXX}"
    fi
done

echo OK.
