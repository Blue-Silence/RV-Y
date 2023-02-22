`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/22 16:42:05
// Design Name: 
// Module Name: IMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
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
    
    //integer i;
    //initial 
      //  for(i=0;i<256;i=i+1)
        //    mem[i]=0;
    initial begin 
    $readmemh("E:/Programming/RV-Y/insmem_h.txt", mem);
    end
    assign Out = mem[addr];
    
endmodule
