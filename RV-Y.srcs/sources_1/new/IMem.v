`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/22 16:42:05
// Module Name: IMem
//////////////////////////////////////////////////////////////////////////////////


module IMem(
        input [63:0] A,
        input [63:0] In,
        input MemWE,
        input clk,
        output [63:0] Out
    );
    
    reg [63:0] mem [0:255];
    wire [7:0] addr;
    assign addr = A[10:3];
    
    always @ (posedge clk) begin
    if(MemWE)
        mem[addr] <= In;
    end
    
    initial begin 
    $readmemh("E:/lab8_student_vivado/insmem_h.txt", mem);
    end
    
    assign Out = mem[addr];
    
endmodule
