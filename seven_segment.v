module seven_segment (
    input  wire       clk,
    input  wire       reset,

    input  wire [5:0] amount,

    output reg  [7:0] seg,
    output reg  [7:0] an
);

    // =========================================================
    // Refresh counter
    // =========================================================

    reg [17:0] refresh_counter;

    always @(posedge clk or posedge reset) begin

        if (reset)
            refresh_counter <= 18'd0;

        else
            refresh_counter <= refresh_counter + 1'b1;

    end

    wire [1:0] digit_select;

    assign digit_select = refresh_counter[17:16];

    // =========================================================
    // Digit values
    // =========================================================

    reg [3:0] digit;

    integer value;

    always @(*) begin

        value = amount;

        case (digit_select)

            2'b00: begin
                an = 8'b11111110;
                digit = value % 10;
            end

            2'b01: begin
                an = 8'b11111101;
                digit = (value / 10) % 10;
            end

            2'b10: begin
                an = 8'b11111011;
                digit = 0;
            end

            2'b11: begin
                an = 8'b11110111;
                digit = 0;
            end

        endcase

        // Active-low seven-segment
        case (digit)

            4'd0: seg = 8'b11000000;
            4'd1: seg = 8'b11111001;
            4'd2: seg = 8'b10100100;
            4'd3: seg = 8'b10110000;
            4'd4: seg = 8'b10011001;
            4'd5: seg = 8'b10010010;
            4'd6: seg = 8'b10000010;
            4'd7: seg = 8'b11111000;
            4'd8: seg = 8'b10000000;
            4'd9: seg = 8'b10010000;

            default:
                seg = 8'b11111111;

        endcase

    end

endmodule
