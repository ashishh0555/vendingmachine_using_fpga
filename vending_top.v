module vending_top (

    input  wire       CLK100MHZ,

    input  wire       BTNC,
    input  wire       BTNU,
    input  wire       BTND,
    input  wire       BTNL,
    input  wire       BTNR,

    output wire [3:0] LED,

    output wire [7:0] SEG,
    output wire [7:0] AN

);

    // =========================================================
    // BUTTON PULSES
    // =========================================================

    wire reset_pulse;
    wire select10_pulse;
    wire select20_pulse;
    wire coin5_pulse;
    wire coin10_pulse;


    // =========================================================
    // DEBOUNCERS
    // =========================================================

    button_debounce reset_button (
        .clk(CLK100MHZ),
        .reset(1'b0),
        .button_in(BTNC),
        .button_pulse(reset_pulse)
    );


    button_debounce select10_button (
        .clk(CLK100MHZ),
        .reset(reset_pulse),
        .button_in(BTNU),
        .button_pulse(select10_pulse)
    );


    button_debounce select20_button (
        .clk(CLK100MHZ),
        .reset(reset_pulse),
        .button_in(BTND),
        .button_pulse(select20_pulse)
    );


    button_debounce coin5_button (
        .clk(CLK100MHZ),
        .reset(reset_pulse),
        .button_in(BTNL),
        .button_pulse(coin5_pulse)
    );


    button_debounce coin10_button (
        .clk(CLK100MHZ),
        .reset(reset_pulse),
        .button_in(BTNR),
        .button_pulse(coin10_pulse)
    );


    // =========================================================
    // VENDING MACHINE
    // =========================================================

    wire dispense10;
    wire dispense20;
    wire change;

    wire [5:0] amount;


    vending_core vending_machine (

        .clk(CLK100MHZ),

        .reset(reset_pulse),

        .select_10(select10_pulse),
        .select_20(select20_pulse),

        .coin_5(coin5_pulse),
        .coin_10(coin10_pulse),

        .dispense_10(dispense10),
        .dispense_20(dispense20),

        .change(change),

        .amount(amount)

    );


    // =========================================================
    // LED OUTPUTS
    // =========================================================

    assign LED[0] = dispense10;
    assign LED[1] = dispense20;
    assign LED[2] = change;
    assign LED[3] = (amount >= 20);


    // =========================================================
    // SEVEN SEGMENT DISPLAY
    // =========================================================

    seven_segment display (

        .clk(CLK100MHZ),

        .reset(reset_pulse),

        .amount(amount),

        .seg(SEG),

        .an(AN)

    );

endmodule
