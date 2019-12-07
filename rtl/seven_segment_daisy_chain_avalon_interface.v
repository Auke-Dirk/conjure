module seven_segment_daisy_chain_avalon_interface (
clock, 
resetn, 
// avalon-mm-slave interface
avs_s0_writedata, 
avs_s0_write,
avs_s0_byteenable, 
avs_s0_chipselect, 
// conduit interface	
Q_export);

// avalon-mm interface
input 		clock;
input 		resetn;

// avalon-mm-slave inteface 
input 		avs_s0_chipselect; 
input[3:0] 	avs_s0_byteenable;
input		avs_s0_write; 
input[31:0] avs_s0_writedata;

// conduit signal to the seven segment display
output[7:0]	Q_export;

// wires
wire[3:0] 	local_byteenable;
wire[31:0] 	to_reg;
wire[31:0] 	from_reg;

// Connections
assign to_reg = avs_s0_writedata;

assign local_byteenable = (avs_s0_chipselect & avs_s0_write) ? avs_s0_byteenable : 4'd0;

seven_segment_daisy_chain U1 ( .clock(clock), .resetn(resetn), .D(to_reg), .byteenable(local_byteenable), .Q(from_reg) );

assign Q_export = from_reg[7:0]; 

endmodule
