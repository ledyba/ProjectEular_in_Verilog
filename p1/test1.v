`timescale 10ps / 10ps
`define GTK // 波形表示はVCD(Value Change Dump) ファイル

module test;
   // 入力信号
   reg clk;
   reg reset;

   wire isEnd;
   wire [31:0] sum;
   

   p1 prob(reset, clk, isEnd, sum);

   parameter CLKP = 5000;        // クロック周期 50ns
   parameter CLKH = CLKP/2;      // H レベル時間
   parameter CLKL = CLKP-CLKH;   // L レベル時間
   
   // クロック
   always begin
	  #CLKH clk = 0;
	  #CLKL clk = 1;
   end

   // ダンプファイル出力
`ifdef GTK
   initial begin
	  $dumpfile("test.vcd");
	  $dumpvars(0,test.prob);
   end
`endif

   initial begin : test
	  $display("*** Simulation Started. ***");
	  sys_reset;
	  $display("*** Simulation Initialized. ***");
	  while (~isEnd)
		@(posedge clk);
	  $display("*** Simulation Complete! ***");
	  $display("RESULT: %d", sum);
	  $dumpall;
	  $finish;
   end

   task sys_reset;
	  begin
		 #1 reset = 1;
		 @(posedge clk);
		 reset = 0;
	  end
   endtask // sys_reset
   

endmodule // test
