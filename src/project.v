/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none

module tt_um_gray_to_binary (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Gray to Binary Conversion (4-bit)
  wire [3:0] gray_in = ui_in[3:0];  // Use lower 4 bits of input
  wire [3:0] binary_out;
  
  gray_to_binary #(.N(4)) converter (
    .gray(gray_in),
    .binary(binary_out)
  );

  // Output assignment
  assign uo_out = {4'b0, binary_out};  // Upper 4 bits set to 0, lower 4 bits are binary output

  // Set bidirectional pins to input mode and output to 0
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Combine unused signals to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, ui_in[7:4]};

endmodule

// Gray to Binary Converter Module
module gray_to_binary #(parameter N = 4) (
    input  [N-1:0] gray,
    output [N-1:0] binary
);
    integer i;
    reg [N-1:0] bin_reg;

    always @(*) begin
        bin_reg[N-1] = gray[N-1]; // MSB remains same
        for (i = N-2; i >= 0; i = i - 1)
            bin_reg[i] = bin_reg[i+1] ^ gray[i]; // XOR with next higher binary bit
    end

    assign binary = bin_reg;
endmodule
