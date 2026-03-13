`timescale 1ns/1ps

module testbench;

reg [3:0] A, B;
reg [3:0] ALU_Sel;

wire [3:0] ALU_Out;
wire Carry;
wire [3:0] Remainder;

ALU_4bit_project_ uut (
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out),
    .Carry(Carry),
    .Remainder(Remainder)
);

initial begin

    A = 4'b1010; 
    B = 4'b0011;

    ALU_Sel = 4'b0000; #10;
    ALU_Sel = 4'b0001; #10;
    ALU_Sel = 4'b1000; #10;
    ALU_Sel = 4'b1010; #10;
    ALU_Sel = 4'b1111; #10;

    $stop;

end

endmodule