`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 20:01:40
// Module Name: RegFile
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input [4:0] srcA,
    input [4:0] srcB,
    input [4:0] dst,
    input [63:0] in,
    input regWE,
    input clk,
    output [63:0] a,
    output [63:0] b
    );
    
    reg [63:0] regs [31:0];
    
    wire WE;
    assign WE = (dst != 63'b0) & regWE;
    
    initial begin
    regs[0] = 64'b0;
    end
    
    always @ (posedge clk) begin
        if (WE)
            regs[dst] = in;
    end
    
    assign a = regs[srcA];
    assign b = regs[srcB];
    
endmodule
