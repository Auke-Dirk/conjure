`timescale 10ns / 1ns
module test_file(out);

reg clock;
output out;

assign out = clock;

initial 
begin
	$dumpfile("vcd/test_gtk_wave.vcd");
    $dumpvars(0, test_file);


	#0 clock=1'b0;
	#1 clock=1'b1;
	#1 clock=1'b0;
	#1 clock=1'b1;
	#1 clock=1'b0;

end

endmodule
