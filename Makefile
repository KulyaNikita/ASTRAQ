# ASTRAQ build file.
#
#   make                    build ./ASTRAQ
#   make test               run the small example in tests/
#   make install            copy ASTRAQ to $(DESTDIR)$(PREFIX)/bin
#   make OPENMP=0           build without OpenMP (single-threaded)
#
# CXX, CXXFLAGS, CPPFLAGS and LDFLAGS can be set from the environment
# (conda-build and bioconda set them).

CXX      ?= c++
CXXFLAGS ?= -O3
PREFIX   ?= /usr/local
BINDIR   ?= $(PREFIX)/bin
INSTALL  ?= install

# OpenMP runs the dynamic programming step in parallel (--threads).
# It is on by default. Use OPENMP=0 for compilers without OpenMP support,
# such as Apple clang without libomp.
OPENMP   ?= 1
ifeq ($(OPENMP),1)
OMPFLAGS := -fopenmp
endif

PROG := ASTRAQ

.PHONY: all install test clean

all: $(PROG)

$(PROG): ASTRAQ.cpp CLI11.hpp
	$(CXX) -std=c++17 $(CPPFLAGS) $(CXXFLAGS) $(OMPFLAGS) ASTRAQ.cpp -o $@ $(LDFLAGS) $(OMPFLAGS)

install: $(PROG)
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 755 $(PROG) $(DESTDIR)$(BINDIR)/$(PROG)

test: $(PROG)
	sh tests/run_tests.sh ./$(PROG)

clean:
	rm -f $(PROG)
	rm -rf tests/out
