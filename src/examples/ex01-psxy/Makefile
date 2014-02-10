# $Id:$
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
C: c01a c01b c01c c01d

# "make Fortran", "make F" rules
Fortran: F
F: f01a f01b f01c f01d

# rules for particular targets
c01a: ex01a.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
c01b: ex01b.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
c01c: ex01c.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
c01d: ex01d.c
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS)
f01a: $(GMTF90) ex01a.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)
f01b: $(GMTF90) ex01b.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)
f01c: $(GMTF90) ex01c.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)
f01d: $(GMTF90) ex01d.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LDFLAGS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f c??? c???.exe f??? f???.exe
	-rm -f ex*.grd ex*.cpt
	-rm -f ex*.ps ex*.png
	-rm -f gmt.conf gmt.history
