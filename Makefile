CXXFLAGS = -O2 -Wall -std=c++11 
CXX ?= clang++
MPICXX ?= mpicxx
MPICXX_FLAGS ?= -cxx:$(CXX)

a.out: main.cpp
	${CXX} --version
	${MPICXX} --version
	${MPICXX} -compile_info -link_info ${CXXFLAGS} -o $@ $^
	${MPICXX} ${CXXFLAGS} -o $@ $^

