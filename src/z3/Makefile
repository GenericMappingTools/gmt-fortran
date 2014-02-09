include ../Make.inc

all: z3

z3: ../mGMT.f90 z3.f90
	@echo "Compiling $@"
	@$(FC) -o $@ $(FCFLAGS) -I../ $(LDFLAGS) $^

.PHONY: clean clean_output

clean_output:
	rm -f gmt.history xy.ps xy.png

clean: clean_output
	rm -f mgmt.mod z3
