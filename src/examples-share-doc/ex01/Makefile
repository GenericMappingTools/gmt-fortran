# $Id$
# ----------------------------------------------------------------------
# Makefile for C/Fortran GMT API examples
# svn co svn://gmtserver.soest.hawaii.edu/gmt-fortran gmt-fortran
# compiles with (Linux/Windows) GNU, Intel, PGI: 
#   ex*.c           => c*, c*.exe
#   ex*.f90 gmt.f90 => f*, f*.exe
# ----------------------------------------------------------------------
# check or set macros in Make.inc:
# path to GMT (Linux/Windows): GMT_L, GMT_W
# C/Fortran compiler name and flags: CC, CCFLAGS, FC, FCFLAGS, LIBS
# ----------------------------------------------------------------------

include ../Make.inc
GMTF90=../../gmt.f90

# "make all" rule
all: Fortran

# "make Fortran", "make F" rules
Fortran: F
F: example_01 example_01b

# rules for particular targets
example_01: $(GMTF90) example_01.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
example_01b: $(GMTF90) example_01b.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe example_?? example_??.exe example_??? example_???.exe
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
