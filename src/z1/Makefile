include ../Make.inc

all: z1

z1: ../mGMT.f90 z1.f90
	@echo "Compiling $@"
	@$(FC) -o $@ $(FCFLAGS) -I../ $(LDFLAGS) $^

.PHONY: clean clean_output

clean_output:
	rm -f gmt.history xy.ps xy.png

clean: clean_output
	rm -f mgmt.mod z1
