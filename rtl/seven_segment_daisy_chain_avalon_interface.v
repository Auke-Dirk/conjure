module seven_segment_daisy_chain_avalon_interface (clock, resetn, writedata, readdata, write, read, byteenable, chipselect, Q_export);
// signals for connecting to the Avalon fabric
input clock, resetn, read, write, chipselect; 
input byteenable;
input[31:0] writedata;
output[31:0] readdata;

// signal for exporting register contents outside of the embedded system
output[7:0] Q_export;

wire[3:0] local_byteenable;
wire[31:0] to_reg;
wire[31:0] from_reg;

assign to_reg = writedata;

assign local_byteenable = (chipselect & write) ? byteenable : 4'd0;

seven_segment_daisy_chain U1 ( .clock(clock), .resetn(resetn), .D(to_reg), .byteenable(local_byteenable), .Q(from_reg) );

assign readdata = from_reg;
assign Q_export = from_reg[7:0]; 

endmodule
