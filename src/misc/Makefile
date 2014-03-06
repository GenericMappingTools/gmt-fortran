# $Id$
# ----------------------------------------------------------------------
# Makefile for misc sources
# svn co svn://gmtserver.soest.hawaii.edu/gmt-fortran gmt-fortran
# ----------------------------------------------------------------------

FC=gfortran

all: 2c1f ptr-ptr union

2c1f: 2c1f-c.c 2c1f-f.f90
	$(FC) -o 2c1f 2c1f-c.c 2c1f-f.f90

# compilation error: gfortran, g95
2f1c: 2f1c-c.c 2f1c-f.f90
	$(FC) -o 2f1c 2f1c-c.c 2f1c-f.f90

ptr-ptr: ptr-ptr-c.c ptr-ptr-f.f90
	$(FC) -o ptr-ptr ptr-ptr-c.c ptr-ptr-f.f90

union: union-c.c union-f.f90
	$(FC) -o union union-c.c union-f.f90

.PHONY: clean
clean:
	-rm -f *.o *.obj *.mod *.dwf *.pdb
	-rm -f 2c1f 2f1c ptr-ptr union 2c1f.exe 2f1c.exe ptr-ptr.exe union.exe
