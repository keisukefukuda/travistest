CXXFLAGS = -O2 -Wall -std=c++11 
CXX ?= clang++
MPICXX ?= mpicxx -cxx=clang++

a.out: main.cpp
	${CXX} --version
	${MPICXX} --version
	${MPICXX} -compile_info -link_info ${CXXFLAGS} -o $@ $^
	${MPICXX} ${CXXFLAGS} -o $@ $^

