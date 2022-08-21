blinky:
	mkdir -p output
	yosys -q -p "synth_ice40 -top blinky -json output/blinky.json" rtl/blinky.v
	nextpnr-ice40 --up5k --package sg48 --pcf brot_v4.pcf \
		--asc output/blinky.txt --json output/blinky.json \
		--pcf-allow-unconstrained --opt-timing
	icepack output/blinky.txt output/blinky.bin

clean:
	rm -f output/*

.PHONY: blinky clean
