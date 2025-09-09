/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_gray_to_binary (
    input  wire [7:0] ui_in,    // Dedicated inputs (Gray code)
    output wire [7:0] uo_out,   // Dedicated outputs (Binary code)
    input  wire [7:0] uio_in,   // IOs: Input path (unused)
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock (unused in combinational design)
    input  wire       rst_n     // reset_n - low to reset (unused)
);

  // Gray to Binary conversion
  assign uo_out[7] = ui_in[7]; // MSB remains the same
  assign uo_out[6] = ui_in[6] ^ uo_out[7];
  assign uo_out[5] = ui_in[5] ^ uo_out[6];
  assign uo_out[4] = ui_in[4] ^ uo_out[5];
  assign uo_out[3] = ui_in[3] ^ uo_out[4];
  assign uo_out[2] = ui_in[2] ^ uo_out[3];
  assign uo_out[1] = ui_in[1] ^ uo_out[2];
  assign uo_out[0] = ui_in[0] ^ uo_out[1];

  // Set bidirectional pins as inputs and output 0
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000;  // All bidirectional pins are inputs

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
