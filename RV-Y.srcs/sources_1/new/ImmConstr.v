`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 16:06:23
// Module Name: ImmConstr
//////////////////////////////////////////////////////////////////////////////////


module ImmConstr(
        input [31:0] Instr,
        output [63:0] ImmI,
        output [63:0] ImmS,
        output [63:0] ImmB,
        output [63:0] ImmU,
        output [63:0] ImmJ
    );
    
    assign ImmI = {{53{Instr[31]}},Instr[30:25],Instr[24:21],Instr[20]};
    assign ImmS = {{53{Instr[31]}},Instr[30:25],Instr[11:8],Instr[7]};
    assign ImmB = {{52{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0};
    assign ImmU = {{33{Instr[31]}},Instr[30:20],Instr[19:12],12'b0};
    assign ImmJ = {{44{Instr[31]}},Instr[19:12],Instr[20],Instr[30:25],Instr[24:21],1'b0};
    
endmodule
