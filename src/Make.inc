#
# Locate your libraries and change the followin two lines
#
GMT_INSTALLL_DIR = /opt/apps/GMT/GMT-5-testing
DIR_LIBS= $(GMT_INSTALLL_DIR)/lib/x86_64-linux-gnu
#
FC = gfortran

FCFLAGS = -g -march=native -std=f2003 -Wall -pedantic -fexternal-blas -fcheck=all -ffpe-trap=invalid,zero,overflow,underflow,denormal

LIBS = $(DIR_LIBS)/libgmt.so.5 $(DIR_LIBS)/libpsl.so.5

LDFLAGS = -Wl,-rpath,$(DIR_LIBS) $(LIBS)
