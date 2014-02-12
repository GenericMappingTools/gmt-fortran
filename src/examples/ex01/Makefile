# $Id: Makefile 10 2014-02-10 19:50:16Z remko $
# ----------------------------------------------------------------------
# Makefile for C/Fortran GMT API examples
# svn co svn://gmtserver.soest.hawaii.edu/gmt-fortran gmt-fortran
# compiles with (Linux/Windows) GNU, Intel, PGI: 
#   ex*.c           => c*, c*.exe
#   ex*.f90 gmt.f90 => f*, f*.exe
# ----------------------------------------------------------------------
# check or set macros in Make.inc:
# path to GMT (Linux/Windows): GMT_L, GMT_W
# C/Fortran compiler name and flags: CC, CCFLAGS, FC, FCFLAGS, LDFLAGS
# ----------------------------------------------------------------------

include ../../Make.inc

# "make all" rule
all: Fortran

# "make Fortran", "make F" rules
Fortran: F
F: example_01

# rules for particular targets
example_01: example_01.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)

# "make clean" rule
.PHONY: clean

clean:
	-rm -f *.o *.obj *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe example_??
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
