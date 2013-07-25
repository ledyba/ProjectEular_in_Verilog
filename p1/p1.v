module p1( input Init, input CLK, output IsEnd, output reg [31:0] sum_ );
   parameter Upto = 1000;
   reg [10:0] cnt_;
   reg [1000:0] flags_;
   reg [3:0] 	stage_; //0->Init 1->flags 2->sum_ 3->end
   wire 		IsLoopEnd = cnt_ >= (Upto-1);
   wire 		IsEnd = stage_ == 3;

   wire [13:0] 	c5 = cnt_ * 5;
   wire [13:0] 	c3 = cnt_ * 3;
   initial begin
	  stage_ <= 0;
	  sum_ <= 0;
	  cnt_ <= 0;
   end
   
   always @(posedge CLK) begin
	  flags_[c5] <= (Init | stage_ == 0) ? 0 : ( c5 <= Upto & stage_ == 1 ) ? 1 : flags_[c5];
	  flags_[c3] <= (Init | stage_ == 0) ? 0 : ( c3 <= Upto & stage_ == 1 ) ? 1 : flags_[c3];
	  flags_[cnt_] <= (Init | stage_ == 0) ? 0 : flags_[cnt_];
	  
	  stage_ <= Init ? 0:
				(stage_ == 0 & IsLoopEnd) ? 1:
				(stage_ == 1 & IsLoopEnd) ? 2:
				(stage_ == 2 & IsLoopEnd) ? 3 : stage_;
	  cnt_ <= (IsEnd) ? cnt_:
			  (Init | IsLoopEnd) ? 0:
			  cnt_ + 1;
	  sum_ <= (IsEnd) ? sum_ : (Init | stage_ != 2) ? 0:
			  (flags_[cnt_]) ? (sum_+cnt_) : sum_;
   end

endmodule
