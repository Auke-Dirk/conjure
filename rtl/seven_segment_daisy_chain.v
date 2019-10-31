/**********************************************************************
 * @date 	27. 10, 2019
 * @file 	seven_segment_daisy_chain.v
 * @author	Auke-Dirk Pietersma
 * @note 	modification of the avalone_mm_slave (reg32) example from Making_Qsys_Components.pdf
 *
 * @description
 * Models a daisy chain of seven segment displays. 
 **********************************************************************/

//*********************************************************
module seven_segment_daisy_chain(clock, resetn, D, byteenable, Q);
//*********************************************************

  input clock, resetn;
  input [31:0]byteenable;
  input [31:0] D;
  output reg [31:0] Q;
  
  always@(posedge clock)
    if (!resetn)
      Q <= 4'b0;
    else
    
	begin
      // Enable writing to each byte separately
      if (byteenable[0]) Q[7:0] <= D[7:0];
      if (byteenable[1]) Q[15:8] <= D[15:8];
      if (byteenable[2]) Q[23:16] <= D[23:16];
      if (byteenable[3]) Q[31:24] <= D[31:24];
    end
endmodule
