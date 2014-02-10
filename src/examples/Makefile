# $Id$

DIRS = ex01-psxy ex02-pscoast ex03-grdimage

all:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir all; \
	done

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

.PHONY: clean
clean:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir clean; \
	done
