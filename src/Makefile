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
	install -c -m 644 gmt.mod $(INC_GMT_L)/

clean_module:
	rm -f gmt.mod

clean_examples:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir clean; \
	done

clean: clean_module clean_examples
