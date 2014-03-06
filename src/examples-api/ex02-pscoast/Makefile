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
all: C Fortran

# "make C" rule
C: c02a c02b

# "make Fortran", "make F" rules
Fortran: F
F: f02a f02b

# rules for particular targets
c02a: ex02a.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
c02b: ex02b.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
f02a: $(GMTF90) ex02a.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f02b: $(GMTF90) ex02b.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe f???? f????.exe
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
