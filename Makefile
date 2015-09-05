CXXFLAGS = -O2 -Wall -std=c++11 

ifeq ($(CXX),clang++-3.5)
	CXXFLAGS += -stdlib=libstdc++
endif

MPICXX ?= mpicxx
MPICXX_FLAGS ?= -cxx=$(CXX)

a.out: main.cpp
	$(CXX) --version
	$(MPICXX) $(MPICXX_FLAGS) --version
	$(MPICXX) -compile_info -link_info $(MPICXX_FLAGS) $(CXXFLAGS) -o $@ $^
	$(MPICXX) $(MPICXX_FLAGS) $(CXXFLAGS) -o $@ $^
