#!/bin/sh

set -eu

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

for cand in mpicxx mpicxx-mpich-devel-clang mpicxx.mpich; do
    MPICXX=$(which $cand ||:)
    if [ -x "${MPICXX}" ]; then
        break
    fi
done
    
if [ ! -x "${MPICXX}" ]; then
    echo "ERROR: Can't find mpirun command."
    exit -1
fi

echo MPICXX=${MPICXX}
echo MPIRUN=${MPIRUN}

rm -f ./a.out ||:
make MPICXX=${MPICXX}

for np in 1 2 3 4; do
    echo ${MPIRUN} -n $np ./a.out
    ${MPIRUN} -n $np ./a.out
done

echo OK.
