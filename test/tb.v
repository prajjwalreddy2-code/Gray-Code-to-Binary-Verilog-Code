`default_nettype none
`timescale 1ns / 1ps



/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Replace tt_um_example with your module name:
  tt_um_gray_to_binary user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

  // Gray to Binary Testbench
  initial begin
    // Initialize inputs
    ena = 1;
    clk = 0;
    rst_n = 1;
    uio_in = 0;
    
    $display("Gray -> Binary Conversion Test");
    $display(" Gray | Binary");

    // Test values (using lower 4 bits of ui_in)
    ui_in = 8'b00000000; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000001; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000011; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000010; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000110; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000111; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000101; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00000100; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    ui_in = 8'b00001100; #10;
    $display(" %b -> %b", ui_in[3:0], uo_out[3:0]);

    $finish;
  end

endmodule
