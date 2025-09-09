import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_gray_to_binary(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test Gray to Binary conversion")

    # Test cases: (gray_input, expected_binary_output)
    test_cases = [
        (0b0000, 0b0000),  # 0 -> 0
        (0b0001, 0b0001),  # 1 -> 1
        (0b0011, 0b0010),  # 3 -> 2
        (0b0010, 0b0011),  # 2 -> 3
        (0b0110, 0b0100),  # 6 -> 4
        (0b0111, 0b0101),  # 7 -> 5
        (0b0101, 0b0110),  # 5 -> 6
        (0b0100, 0b0111),  # 4 -> 7
        (0b1100, 0b1000),  # 12 -> 8
    ]

    for gray_input, expected_binary in test_cases:
        # Set the input values
        dut.ui_in.value = gray_input
        dut.uio_in.value = 0  # Not used in our design

        # Wait for one clock cycle to see the output values
        await ClockCycles(dut.clk, 1)

        # Check the output values (only lower 4 bits)
        actual_binary = dut.uo_out.value & 0x0F
        dut._log.info(f"Gray: {gray_input:04b} -> Binary: {actual_binary:04b} (Expected: {expected_binary:04b})")
        
        # Assert the expected output
        assert actual_binary == expected_binary, f"For gray input {gray_input:04b}, expected binary {expected_binary:04b}, but got {actual_binary:04b}"

    dut._log.info("All tests passed!")
