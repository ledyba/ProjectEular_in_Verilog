module core (input Init, input CLK, output IsEnd, output reg [31:0] sum_ );
   parameter Upto = 4000000;
   reg [31:0]   last_;
   reg [31:0] 	now_;
   wire 		IsEnd = now_ >= Upto;

   initial begin
	  sum_ <= 0;
	  last_<= 1;
	  now_ <= 2;
   end
   
   always @(posedge CLK) begin
	  sum_ <= (IsEnd | ((now_ & 1) == 1)) ? sum_ :  sum_ + now_;
	  now_ <= (IsEnd) ? now_ : last_ + now_;
	  last_ <= (IsEnd) ? last_ : now_;
   end

endmodule
