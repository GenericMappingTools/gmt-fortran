# $Id$

# check or set at least these macros: 
# path to GMT: GMT_L, GMT_W
# compiler names and flags: CC, CCFLAGS, FC, FCFLAGS, LIBS

# path to GMT root directory, include files and libraries (Linux/Windows)
GMT_L=/opt/gmt5
GMT_W=c:\programs\gmt5
INCL_L=-I$(GMT_L)/include/gmt
INCL_W=-I$(GMT_W)\include\gmt
LIBS_L=-L$(GMT_L)/lib -lgmt -lpsl
LIBS_W=-L$(GMT_W)\lib -lgmt -lpsl

# C compilers: GNU/Intel/PGI (Linux/Windows)
# -- GNU
CC_GNU=gcc
CCFLAGS_GNU_L=-g $(INCL_L)
CCFLAGS_GNU_W=-g $(INCL_W)
# -- Intel
CC_INT=icc
CCFLAGS_INT_L=-g $(INCL_L)
CCFLAGS_INT_W=-g $(INCL_W)
# -- Portland Group
CC_PGI=pgcc
CCFLAGS_PGI_L=-g $(INCL_L)
CCFLAGS_PGI_W=-g $(INCL_W)

# Fortran compilers: GNU/Intel/PGI (Linux/Windows)
# -- GNU
FC_GNU=gfortran
# FCFLAGS_GNU_L=-g -march=native -std=f2003 -Wall -pedantic -fexternal-blas -fcheck=all -ffpe-trap=invalid,zero,overflow,underflow,denormal
# FCFLAGS_GNU_W=-g -march=native -std=f2003 -Wall -pedantic -fexternal-blas -fcheck=all -ffpe-trap=invalid,zero,overflow,underflow,denormal
# FCFLAGS_GNU_L=-std=f2003 -Wall -pedantic -g -fopenmp
# FCFLAGS_GNU_W=-std=f2003 -Wall -pedantic -g -fopenmp
FCFLAGS_GNU_L=-Wall -pedantic -g -fopenmp
FCFLAGS_GNU_W=-Wall -pedantic -g -fopenmp
# -- Intel
FC_INT=ifort
# FCFLAGS_INT_L=-nologo -e03 -warn -C -g -openmp
# FCFLAGS_INT_W=-nologo -stand:f03 -warn -C -openmp
FCFLAGS_INT_L=-nologo -warn -C -openmp
FCFLAGS_INT_W=-nologo -warn -C -openmp
LIBS_INT_W=$(GMT_W)\lib\gmt.lib
# -- Portland Group
FC_PGI=pgfortran
# FCFLAGS_PGI_L=-Mstandard -Minform=inform -C -Mbounds -g -mp
# FCFLAGS_PGI_W=-Mstandard -Minform=inform -C -Mbounds -g -mp
FCFLAGS_PGI_L=-Mstandard -C -Mbounds -g -mp
FCFLAGS_PGI_W=-Mstandard -C -Mbounds -g -mp

# selected set of compiler names and flags
CC     =$(CC_GNU)
CCFLAGS=$(CCFLAGS_GNU_L)
FC     =$(FC_GNU)
FCFLAGS=$(FCFLAGS_GNU_L)
LIBS   =$(LIBS_L)
