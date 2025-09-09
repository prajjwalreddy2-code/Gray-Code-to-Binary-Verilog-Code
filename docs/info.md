<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
This repository contains the schematic and simulation for a Gray Code to Binary Code converter implemented using XOR logic gates.
- Inputs Gray Code using switches
- Converts Gray Code to Binary using XOR logic
- Outputs Binary code on LEDs
- The Gray code input is passed through multiplexed IO blocks.
- XOR gates are arranged such that:
  - The MSB of Binary output equals the MSB Gray code input.
  - Each lower order binary bit is calculated as XOR between previous Binary output and corresponding Gray input.
- Outputs display Binary code on color-coded LEDs.

## How to test
Create a testbench module that inputs different Gray code combinations to your converter module.

Observe the binary output and verify if it matches the expected binary equivalent of the Gray inputs.

Use simulation tools (like ModelSim, Vivado, or any Verilog simulator) to run the testbench and check waveform or print output results.

## External hardware

Switches, XOR gates , LEDs,  power supply.
