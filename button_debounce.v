module button_debounce (
    input  wire clk,
    input  wire reset,
    input  wire button_in,

    output wire button_pulse
);

    // =========================================================
    // Synchronizer
    // =========================================================

    reg sync1;
    reg sync2;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            sync1 <= 1'b0;
            sync2 <= 1'b0;
        end

        else begin
            sync1 <= button_in;
            sync2 <= sync1;
        end

    end

    // =========================================================
    // Debounce counter
    // =========================================================

    reg [19:0] counter;
    reg stable_button;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            counter       <= 20'd0;
            stable_button <= 1'b0;
        end

        else begin

            if (sync2 == stable_button) begin

                counter <= 20'd0;

            end

            else begin

                if (counter == 20'd999999) begin

                    stable_button <= sync2;
                    counter       <= 20'd0;

                end

                else begin

                    counter <= counter + 1'b1;

                end

            end

        end

    end

    // =========================================================
    // Rising-edge detector
    // =========================================================

    reg stable_button_previous;

    always @(posedge clk or posedge reset) begin

        if (reset)
            stable_button_previous <= 1'b0;

        else
            stable_button_previous <= stable_button;

    end

    assign button_pulse =
        stable_button & ~stable_button_previous;

endmodule
