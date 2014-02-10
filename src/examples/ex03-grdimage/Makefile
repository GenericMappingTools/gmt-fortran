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
# C/Fortran compiler name and flags: CC, CCFLAGS, FC, FCFLAGS, LDFLAGS
# ----------------------------------------------------------------------

include ../Make.inc
GMTF90=../../gmt.f90

# "make all" rule
all: C Fortran

# "make C" rule
C: c03a c03b

# "make Fortran", "make F" rules
Fortran: F
F: f03a f03b

# rules for particular targets
c03a: ex03a.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
c03b: ex03b.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
f03a: $(GMTF90) ex03a.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)
f03b: $(GMTF90) ex03b.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
