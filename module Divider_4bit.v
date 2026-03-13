module Divider_4bit(
    input [3:0] dividend,
    input [3:0] divisor,
    output reg [3:0] quotient,
    output reg [3:0] remainder
);

integer i;

always @(*) begin

    quotient = 0;
    remainder = 0;

    for(i = 3; i >= 0; i = i - 1) begin
        remainder = (remainder << 1) | dividend[i];

        if(remainder >= divisor) begin
            remainder = remainder - divisor;
            quotient[i] = 1;
        end
    end

end

endmodule