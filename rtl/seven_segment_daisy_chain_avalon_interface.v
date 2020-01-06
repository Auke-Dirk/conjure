module seven_segment_daisy_chain_avalon_interface (
clock, 
resetn,
// avalon-mm-master interface
avm_m0_writedata, 
avm_m0_write,
avm_m0_byteenable, 
avm_m0_chipselect,
avm_m0_address,
avm_m0_waitrequest,

// avalon-mm-slave interface
avs_s0_writedata, 
avs_s0_write,
avs_s0_byteenable, 
avs_s0_chipselect,
//avs_s0_address,
avs_s0_waitrequest,
 
// conduit interface	
Q_export);

// avalon-mm interface
input 		clock;
input 		resetn;

// avalon-mm-slave inteface 
input 		avs_s0_chipselect; 
input[3:0] 	avs_s0_byteenable;
input		avs_s0_write; 
input[31:0] 	avs_s0_writedata;
//input[7:0]      avs_s0_address;
output          avs_s0_waitrequest;

// avalon-mm-master inteface 
output 		avm_m0_chipselect; 
output[3:0] 	avm_m0_byteenable;
output		avm_m0_write; 
output[31:0] 	avm_m0_writedata;
output[7:0]     avm_m0_address;
input           avm_m0_waitrequest;

// conduit signal to the seven segment display
output[7:0]	Q_export;

// wires
wire[3:0] 	local_byteenable;
wire[31:0] 	to_reg;
wire[31:0] 	from_reg;

// Connections
assign to_reg = avs_s0_writedata;

assign local_byteenable = (avs_s0_chipselect & avs_s0_write) ? avs_s0_byteenable : 4'd0;

assign avs_s0_waitrequest = 0;
assign avm_m0_chipselect  = avs_s0_chipselect;
assign avm_m0_byteenable  = avs_s0_byteenable;
assign avm_m0_write       = avs_s0_write;
assign avm_m0_writedata   = avs_s0_writedata;
 		

seven_segment_daisy_chain U1 ( .clock(clock), .resetn(resetn), .D(to_reg), .byteenable(local_byteenable), .Q(from_reg) );

assign Q_export = from_reg[7:0]; 

endmodule
