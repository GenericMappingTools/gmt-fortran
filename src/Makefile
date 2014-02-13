# $Id: Makefile 10 2014-02-10 19:50:16Z remko $

include ./Make.inc

DIRS = examples

all: $(INC_GMT_L)/gmt.mod
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir all; \
	done

gmt.mod: gmt.f90
	$(FC) $(FCFLAGS_MOD) $<
	ar rvs libgmtf.a gmt.o
	gcc -shared -Wl,-soname,libgmtf.so.1 -o libgmtf.so.1.0.1 gmt.o

C:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir C; \
	done

Fortran: F
F:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir F; \
	done

.PHONY: install_module clean_module clean_examples clean

$(INC_GMT_L)/gmt.mod: gmt.mod
	install -c -m 644 gmt.mod $(INC_DIR_GMT)/
	rm -f $(LIB_DIR_GMT)/libgmtf.so.1
	rm -f $(LIB_DIR_GMT)/libgmtf.so
	install -c -m 644 libgmtf.* $(LIB_DIR_GMT)/
	cd $(LIB_DIR_GMT); ln -s libgmtf.so.1.0.1 libgmtf.so.1; ln -s libgmtf.so.1.0.1 libgmtf.so; ldconfig

clean_module:
	rm -f gmt.mod gmt.o libgmtf.*

clean_examples:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir clean; \
	done

clean: clean_module clean_examples
