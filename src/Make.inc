# $Id: Make.inc-LINUX 10 2014-02-10 19:50:16Z remko $

# check or set at least these macros: 
# path to GMT: GMT_L, GMT_W
# compiler names and flags: CC, CCFLAGS, FC, FCFLAGS, LDFLAGS

# path to GMT root directory, include files and libraries (Linux/Windows)
GMT_L             = /opt/gmt/5.1.0
GMT_W             = c:\programs\gmt5
INC_GMT_L         = $(GMT_L)/include/gmt
INC_GMT_W         = $(GMT_W)\include\gmt
INCL_L            = -I$(INC_GMT_L)
INCL_W            = -I$(INC_GMT_W)
LIBS_L            = -L$(GMT_L)/lib -lgmt -lpsl
LIBS_W            = -L$(GMT_W)\lib -lgmt -lpsl
INST_MOD_L        = $(INC_GMT_L)
INST_MOD_W        = $(INC_GMT_W)

# C compilers: GNU/Intel/PGI (Linux/Windows)
CC_GNU            = gcc
CCFLAGS_GNU_L     = -g $(INCL_L)
CCFLAGS_GNU_W     = -g $(INCL_W)
CC_INT            = icc
CCFLAGS_INT_L     = -g $(INCL_L)
CCFLAGS_INT_W     = -g $(INCL_W)
CC_PGI            = pgcc
CCFLAGS_PGI_L     = -g $(INCL_L)
CCFLAGS_PGI_W     = -g $(INCL_W)

# Fortran compilers: GNU/Intel/PGI/g95 (Linux/Windows)
#
# GNU gfortran
#
FC_GNU            = gfortran
FCFLAGS_GNU_L     = -std=f2003 -Wall -pedantic -g $(INCL_L)
FCFLAGS_GNU_W     = -std=f2003 -Wall -pedantic -g $(INCL_W)
FCFLAGS_GNU_MOD_L = -std=f2003 -Wall -pedantic -g -c -fsyntax-only
FCFLAGS_GNU_MOD_W = -std=f2003 -Wall -pedantic -g -c -fsyntax-only
#
# Intel ifort
#
FC_INT            = ifort
FCFLAGS_INT_L     = -nologo -e03 -warn -C -g
FCFLAGS_INT_W     = -nologo -stand:f03 -warn -C -g
FCFLAGS_INT_MOD_L = -nologo -e03 -warn -C -g -c
FCFLAGS_INT_MOD_W = -nologo -stand:f03 -warn -C -c
#
# Portland Group pgfortran
#
FC_PGI            = pgfortran
FCFLAGS_PGI_L     = -Mstandard -Minform=inform -C -Mbounds -g
FCFLAGS_PGI_W     = -Mstandard -Minform=inform -C -Mbounds -g
#
FC_G95            = g95
FCFLAGS_G95_L     = -std=f2003 -Wall -pedantic -g
FCFLAGS_G95_W     = -std=f2003 -Wall -pedantic -g

# selected set of compiler names and flags
CC                = $(CC_GNU)
CCFLAGS           = $(CCFLAGS_GNU_L)
FC                = $(FC_GNU)
FCFLAGS           = $(FCFLAGS_GNU_L)
LDFLAGS           = $(LIBS_L)
FCFLAGS_MOD       = $(FCFLAGS_GNU_MOD_L)