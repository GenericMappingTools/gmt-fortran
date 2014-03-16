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
GMTMISC=../../gmt_misc.f90

# "make all" rule
all: Fortran

# "make Fortran", "make F" rules
Fortran: F
F: anim_04

# rules for particular targets
anim_04: $(GMTF90) $(GMTMISC) anim_04.f90
	$(FC) -o $@ $(FCFLAGS) $^ $(LIBS)

# "make clean" rule
.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f anim_?? anim_??.exe
	-rm -f ????.cpt ????.path.d ????_int*.nc anim_04_*.ps
	-rm -f frames/*
	-rmdir frames
	-rm -f gmt.conf gmt.history
