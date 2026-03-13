module ALU_4bit_project(
    input [3:0] A, B,          // Operands
    input [3:0] ALU_Sel,       // Operation select
    output [3:0] ALU_Out,      // Result
    output Carry,              // Carry output (for addition)
    output [3:0] Remainder     // Remainder (only for division)
);

reg [3:0] ALU_result;
wire [4:0] tmp;
wire [3:0] div_qr, div_r;

// Instantiate Divider
Divider_4bit div_inst (
    .dividend(A),
    .divisor(B),
    .quotient(div_qr),
    .remainder(div_r)
);

assign ALU_Out = ALU_result;
assign tmp = {1'b0, A} + {1'b0, B};
assign Carry = tmp[4];

always @(*) begin
    case(ALU_Sel)

        4'b0000: ALU_result = A + B;
        4'b0001: ALU_result = A - B;
        4'b0010: ALU_result = A * B;
        4'b0011: ALU_result = (A == B) ? 4'd1 : 4'd0;

        4'b0100: ALU_result = A << 1;
        4'b0101: ALU_result = A >> 1;

        4'b0110: ALU_result = {A[2:0], A[3]};
        4'b0111: ALU_result = {A[0], A[3:1]};

        4'b1000: ALU_result = A & B;
        4'b1001: ALU_result = A | B;
        4'b1010: ALU_result = A ^ B;
        4'b1011: ALU_result = ~(A | B);

        4'b1100: ALU_result = ~(A & B);
        4'b1101: ALU_result = ~(A ^ B);

        4'b1110: ALU_result = (A > B) ? 4'd1 : 4'd0;

        4'b1111: ALU_result = div_qr;

        default: ALU_result = 4'b0000;

    endcase
end

assign Remainder = (ALU_Sel == 4'b1111) ? div_r : 4'b0000;

endmodule