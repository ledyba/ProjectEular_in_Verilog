all:
	iverilog core.v test.v -o __out__.out
	vvp __out__.out
	rm __out__.out
	gtkwave test.vcd
	rm test.vcd
