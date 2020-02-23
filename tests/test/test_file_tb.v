`timescale 10ns / 10ns
module test_file(out);

reg clock;
output out;

assign out = clock;

initial 
begin

	#0 clock=1'b0;
	#1 clock=1'b1;
	#2 clock=1'b0;
	#3 clock=1'b1;

end


always @(clock) 
begin
  $display("%b",out);
end

endmodule
