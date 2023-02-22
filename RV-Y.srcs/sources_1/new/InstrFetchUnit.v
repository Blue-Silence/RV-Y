`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 21:02:43
// Module Name: InstrFetchUnit
//////////////////////////////////////////////////////////////////////////////////


module InstrFetchUnit(
        input [63:0] pc,
        input clk,
        output [31:0] instr
    );
    
    wire [63:0] instrArray;
    //Mem imem (pc, 1'b0, 1'b0, clk, instrArray);
    IMem imem (pc, 1'b0, 1'b0, clk, instrArray);
    assign instr = (pc[2]) ? instrArray[63:32] : instrArray[31:0];

endmodule
