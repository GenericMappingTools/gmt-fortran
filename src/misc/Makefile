# $Id$
# ----------------------------------------------------------------------
# Makefile for misc sources
# svn co svn://gmtserver.soest.hawaii.edu/gmt-fortran gmt-fortran
# ----------------------------------------------------------------------

FC=gfortran

all: ptr-ptr union

ptr-ptr: ptr-ptr-c.c ptr-ptr-f.f90
	$(FC) -o ptr-ptr ptr-ptr-c.c ptr-ptr-f.f90

union: union-c.c union-f.f90
	$(FC) -o union union-c.c union-f.f90

.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f ptr-ptr union ptr-ptr.exe union.exe
