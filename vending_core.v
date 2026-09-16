module vending_core (
    input  wire       clk,
    input  wire       reset,

    input  wire       select_10,
    input  wire       select_20,

    input  wire       coin_5,
    input  wire       coin_10,

    output reg        dispense_10,
    output reg        dispense_20,
    output reg        change,

    output reg [5:0]  amount
);

    // =========================================================
    // FSM STATES
    // =========================================================

    localparam S0  = 3'b000;
    localparam S5  = 3'b001;
    localparam S10 = 3'b010;
    localparam S15 = 3'b011;
    localparam S20 = 3'b100;

    reg [2:0] state;

    // =========================================================
    // PRODUCT SELECTION
    // =========================================================

    reg product_10;
    reg product_20;

    // =========================================================
    // NEXT AMOUNT
    // =========================================================

    reg [5:0] next_amount;

    // =========================================================
    // PRODUCT SELECTION REGISTER
    // =========================================================

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            product_10 <= 1'b0;
            product_20 <= 1'b0;
        end

        else begin

            if (select_10) begin
                product_10 <= 1'b1;
                product_20 <= 1'b0;
            end

            else if (select_20) begin
                product_10 <= 1'b0;
                product_20 <= 1'b1;
            end

        end

    end

    // =========================================================
    // MAIN FSM
    // =========================================================

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            state         <= S0;
            amount        <= 6'd0;

            dispense_10   <= 1'b0;
            dispense_20   <= 1'b0;
            change        <= 1'b0;

        end

        else begin

            // Default outputs are OFF
            dispense_10 <= 1'b0;
            dispense_20 <= 1'b0;
            change      <= 1'b0;

            // -----------------------------------------------
            // Calculate new amount
            // -----------------------------------------------

            next_amount = amount;

            if (coin_5)
                next_amount = amount + 6'd5;

            else if (coin_10)
                next_amount = amount + 6'd10;


            // -----------------------------------------------
            // If a coin was inserted
            // -----------------------------------------------

            if (coin_5 || coin_10) begin

                // ===========================================
                // ₹10 PRODUCT
                // ===========================================

                if (product_10 && (next_amount >= 10)) begin

                    dispense_10 <= 1'b1;

                    if (next_amount > 10)
                        change <= 1'b1;

                    // Transaction completed
                    amount <= 6'd0;
                    state  <= S0;

                end

                // ===========================================
                // ₹20 PRODUCT
                // ===========================================

                else if (product_20 && (next_amount >= 20)) begin

                    dispense_20 <= 1'b1;

                    if (next_amount > 20)
                        change <= 1'b1;

                    // Transaction completed
                    amount <= 6'd0;
                    state  <= S0;

                end

                // ===========================================
                // INSUFFICIENT MONEY
                // ===========================================

                else begin

                    amount <= next_amount;

                    case (next_amount)

                        6'd0:
                            state <= S0;

                        6'd5:
                            state <= S5;

                        6'd10:
                            state <= S10;

                        6'd15:
                            state <= S15;

                        default:
                            state <= S20;

                    endcase

                end

            end

        end

    end

endmodule
