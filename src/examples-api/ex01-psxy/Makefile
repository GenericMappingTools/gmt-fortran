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
C: c01a c01b c01c c01d

# "make Fortran", "make F" rules
Fortran: F
F: f01a1 f01a2 f01a3 f01a4 f01a5 f01b1 f01b2 f01c1 f01c2 f01d1 f01d2

# rules for particular targets
c01a: ex01a.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
c01b: ex01b.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
c01c: ex01c.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
c01d: ex01d.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LIBS)
f01a1: $(GMTF90) ex01a1.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01a2: $(GMTF90) ex01a2.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01a3: $(GMTF90) ex01a3.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01a4: $(GMTF90) ex01a4.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01a5: $(GMTF90) ex01a5.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01b1: $(GMTF90) ex01b1.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01b2: $(GMTF90) ex01b2.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01c1: $(GMTF90) ex01c1.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01c2: $(GMTF90) ex01c2.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01d1: $(GMTF90) ex01d1.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)
f01d2: $(GMTF90) ex01d2.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe f???? f????.exe
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
