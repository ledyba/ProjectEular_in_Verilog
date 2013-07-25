all:
	iverilog p1.v test1.v -o test1.out
	vvp test1.out
	rm test1.out
	gtkwave.exe test.vcd
