
help:
	@echo
	@echo "make lcd_test.blif      run synthesis, generate BLIF netlist"
	@echo "make lcd_test.asc       run place and route, generate IceStorm ASCII file"
	@echo "make lcd_test.bin       run timing analysis, generate iCE40 BIN file"
	@echo
	@echo
	@echo "make clean             remove output files"
	@echo

SOURCES=$(wildcard *.v)

lcd_test.blif: $(SOURCES)
	yosys -p 'synth_ice40 -top top -blif lcd_test.blif' $(SOURCES)

lcd_test.asc: lcd_test.blif badge.pcf
	arachne-pnr -d 5k -p badge.pcf -o lcd_test.asc lcd_test.blif 

lcd_test.bin: lcd_test.asc
	icetime -d up5k -c 24 lcd_test.asc
	icepack lcd_test.asc lcd_test.bin

prog_sram: lcd_test.bin
	iceprog -S lcd_test.bin

prog_flash: lcd_test.bin
	iceprog lcd_test.bin

clean:
	rm lcd_test.blif lcd_test.asc lcd_test.bin

.PHONY: prog_sram prog_flash reset_halt reset_boot clean
