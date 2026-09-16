`timescale 1ns / 1ps

module vending_tb;

    reg clk;
    reg reset;

    reg select_10;
    reg select_20;

    reg coin_5;
    reg coin_10;

    wire dispense_10;
    wire dispense_20;
    wire change;

    wire [5:0] amount;


    // =========================================================
    // DUT
    // =========================================================

    vending_core DUT (

        .clk(clk),

        .reset(reset),

        .select_10(select_10),
        .select_20(select_20),

        .coin_5(coin_5),
        .coin_10(coin_10),

        .dispense_10(dispense_10),
        .dispense_20(dispense_20),

        .change(change),

        .amount(amount)

    );


    // =========================================================
    // CLOCK
    // =========================================================

    initial begin

        clk = 0;

        forever #5 clk = ~clk;

    end


    // =========================================================
    // TEST
    // =========================================================

    initial begin

        reset     = 1'b1;

        select_10 = 1'b0;
        select_20 = 1'b0;

        coin_5    = 1'b0;
        coin_10   = 1'b0;

        #20;

        reset = 1'b0;


        // =====================================================
        // TEST 1
        // ₹10 PRODUCT
        // INSERT ₹10
        // =====================================================

        #10;

        select_10 = 1'b1;
        #10;
        select_10 = 1'b0;

        #10;

        coin_10 = 1'b1;
        #10;
        coin_10 = 1'b0;

        #20;


        // =====================================================
        // TEST 2
        // ₹20 PRODUCT
        // INSERT ₹5 + ₹5 + ₹10
        // =====================================================

        select_20 = 1'b1;
        #10;
        select_20 = 1'b0;

        #10;

        coin_5 = 1'b1;
        #10;
        coin_5 = 1'b0;

        #10;

        coin_5 = 1'b1;
        #10;
        coin_5 = 1'b0;

        #10;

        coin_10 = 1'b1;
        #10;
        coin_10 = 1'b0;

        #20;


        // =====================================================
        // TEST 3
        // ₹10 PRODUCT
        // INSERT ₹15
        // SHOULD GIVE CHANGE
        // =====================================================

        select_10 = 1'b1;
        #10;
        select_10 = 1'b0;

        #10;

        coin_10 = 1'b1;
        #10;
        coin_10 = 1'b0;

        #10;

        coin_5 = 1'b1;
        #10;
        coin_5 = 1'b0;

        #30;


        // =====================================================
        // TEST 4
        // RESET
        // =====================================================

        reset = 1'b1;

        #20;

        reset = 1'b0;

        #20;

        $finish;

    end

endmodule
