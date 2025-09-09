`default_nettype none
`timescale 1ns / 1ps

module tt_um_gray_to_binary (
    input  wire [7:0] ui_in,    // Dedicated inputs (Gray code)
    output wire [7:0] uo_out,   // Dedicated outputs (Binary code)
    input  wire [7:0] uio_in,   // IOs: Input path (unused)
    output wire [7:0] uio_out,  // IOs: Output path (set to 0)
    output wire [7:0] uio_oe,   // IOs: Enable path (all inputs)
    input  wire       ena,      // enable - high when design selected
    input  wire       clk,      // clock (unused in combinational design)
    input  wire       rst_n     // reset (unused)
);

    // Set bidirectional pins as inputs and output 0
    assign uio_oe = 8'b00000000;
    assign uio_out = 8'b00000000;

    // Gray to Binary conversion
    assign uo_out[7] = ui_in[7];
    assign uo_out[6] = ui_in[6] ^ uo_out[7];
    assign uo_out[5] = ui_in[5] ^ uo_out[6];
    assign uo_out[4] = ui_in[4] ^ uo_out[5];
    assign uo_out[3] = ui_in[3] ^ uo_out[4];
    assign uo_out[2] = ui_in[2] ^ uo_out[3];
    assign uo_out[1] = ui_in[1] ^ uo_out[2];
    assign uo_out[0] = ui_in[0] ^ uo_out[1];

endmodule

// Testbench
module tb ();

    // Wire up the inputs and outputs
    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate the design
    tt_um_gray_to_binary user_project (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Generate clock
    initial begin
        clk = 0;
        forever #12.5 clk = ~clk;
    end

    // Initialize signals and run tests
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
        
        // Initialize
        rst_n = 0;
        ena = 0;
        ui_in = 0;
        uio_in = 0;
        #20;
        
        // Activate design
        rst_n = 1;
        ena = 1;
        #20;

        // Test cases
        $display("Testing Gray to Binary Conversion:");
        $display("Gray   | Binary");
        
        ui_in = 8'b00000000; #20;
        $display("%b | %b", ui_in, uo_out);
        
        ui_in = 8'b00000001; #20;
        $display("%b | %b", ui_in, uo_out);
        
        ui_in = 8'b00000011; #20;
        $display("%b | %b", ui_in, uo_out);
        
        ui_in = 8'b00000010; #20;
        $display("%b | %b", ui_in, uo_out);
        
        ui_in = 8'b00000110; #20;
        $display("%b | %b", ui_in, uo_out);
        
        // Add more test cases as needed
        
        #100 $finish;
    end

endmodule
