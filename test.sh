#!/bin/sh

set -eu

if [ "xtravis" = "x${1:-}" ]; then
    COMPILERS=("clang++-3.5" "g++-5" "g++-4.9")
else
    COMPILERS=("clang++")
fi

for comp in ${COMPILERS[@]}; do
    echo "-----------------------------------"
    echo compiler = ${comp}
    rm -f ./a.out ||:
    make MPICXX=mpicxx CXX=${comp}
    for np in 1 2 3 4; do
        echo mpirun -n $np ./a.out
        mpirun -n $np ./a.out
    done
done

echo OK.
