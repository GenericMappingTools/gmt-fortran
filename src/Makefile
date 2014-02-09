DIRS = z1 z2 z3 z4

all:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir all; \
	done

.PHONY: clean

clean:
	@for dir in $(DIRS); \
	do \
		$(MAKE) -C $$dir clean; \
	done
