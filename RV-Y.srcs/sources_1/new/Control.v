`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 16:00:21
// Design Name: 
// Module Name: Control
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


module Control(
            input [6:0] opcode,
            input [6:0] funct7,
            input [2:0] funct3,
            
            output [2:0] instrType, //000:R ; 001:I ; 010:S ; 011:B ; 100:U ; 101:J
            
            output [1:0] instrFlowType, //00:no branch; 01:jl; 10:conditional;  11:jlr
            
            output memWE,
            output memRegE,
            
            output [1:0] resultType, //00:ALU; 01:Mem; 10:pc; 11: imm
            output [1:0] dstType, //00:rd, others : disable  
            
            output aluImmE
    );
    //Undefined.
    assign instrType = ((opcode == 7'D3) || (opcode == 7'D19) || (opcode == 7'D27)) ? 3'b001 : //I
                       (opcode == 7'D35) ? 3'b010 : //S
                       (opcode == 7'D99) ? 3'b011 : //B
                       (opcode == 7'D111) ? 3'b101 : //J
                       3'b100; //U or R
    
    assign instrFlowType = (opcode == 7'D99) ? 2'b10 : //conditional
                           (opcode == 7'D103) ? 2'b11 : //jlr
                           (opcode == 7'D111) ? 2'b01 : //jl
                           00;//no branch
    
    assign memWE = (opcode == 7'D35);
    assign memRegE = (opcode == 7'D3) || (opcode == 7'D35);
    
    assign aluImmE = (opcode == 7'D19) || (opcode == 7'D27);
    
    assign resultType = (opcode == 7'D3) ? 2'b01 : //Mem
                        ((opcode == 7'D103) || (opcode == 7'D111)) ? 2'b10 : //Pc
                        00; //ALU
    assign dstType =    (opcode == 7'D3) || 
                        (opcode == 7'D19) || 
                        (opcode == 7'D23) ||
                        (opcode == 7'D51) ||
                        (opcode == 7'D55) ||
                        (opcode == 7'D103) ||
                        (opcode == 7'D111) ||
                        (opcode == 7'D27) ||
                        (opcode == 7'D59);
                        
    
    
    
    
    
    
    

endmodule