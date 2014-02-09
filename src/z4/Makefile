include ../Make.inc

all: z4

z4: ../mGMT.f90 z4.f90
	@echo "Compiling $@"
	@$(FC) -o $@ $(FCFLAGS) -I../ $(LDFLAGS) $^

.PHONY: clean clean_output

clean_output:
	rm -f gmt.history xyz.ps xyz.png

clean: clean_output
	rm -f mgmt.mod z4
