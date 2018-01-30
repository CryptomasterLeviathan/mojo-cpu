//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:51 01/24/2018 
// Design Name: 
// Module Name:    cpu_example_rom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "cpu_example_instructions.h"

module cpu_example_rom(
		input clk,
		input [7:0] addr,
		output [15:0] data
	);

	reg [15:0] data;

	wire [15:0] rom_data [21:0];

	assign rom_data[0] = {`SET, 4'd2, 8'd1};              // SET R2, 0
	// loop:
	assign rom_data[1] = {`SET, 4'd1, 8'd128};            // SET R1, 128
	assign rom_data[2] = {`STORE, 4'd2, 4'd1, 4'd0};      // STORE R2, R1, 0
	assign rom_data[3] = {`SET, 4'd1, 8'd1};              // SET R1, 1
	assign rom_data[4] = {`ADD, 4'd2, 4'd2, 4'd1};        // ADD R2, R2, R1
	assign rom_data[5] = {`SET, 4'd15, 8'd1};             // SET R15, loop
	assign rom_data[6] = {`SET, 4'd0, 8'd7};              // SET R0, delay
	// delay:
	assign rom_data[7] = {`SET, 4'd11, 8'd0};             // SET R11, 0
	assign rom_data[8] = {`SET, 4'd12, 8'd0};             // SET R12, 0
	assign rom_data[9] = {`SET, 4'd13, 8'd0};             // SET R13, 0
	assign rom_data[10] = {`SET, 4'd1, 8'd1};             // SET R1, 1
	// delay_loop:
	assign rom_data[11] = {`ADD, 4'd11, 4'd11, 4'd1};     // ADD R11, R11, R1
	assign rom_data[12] = {`BEQ, 4'd11, 8'd0};            // BEQ R11, 0
	assign rom_data[13] = {`SET, 4'd0, 8'd11};            // SET R0, delay_loop
	assign rom_data[14] = {`ADD, 4'd12, 4'd12, 4'd1};     // ADD R12, R12, R1
	assign rom_data[15] = {`BEQ, 4'd12, 8'd0};            // BEQ R12, 0
	assign rom_data[16] = {`SET, 4'd0, 8'd11};            // SET R0, delay_loop
	assign rom_data[17] = {`ADD, 4'd13, 4'd13, 4'd1};     // ADD R13, R13, R1
	assign rom_data[18] = {`BEQ, 4'd13, 8'd0};            // BEQ R13, 0
	assign rom_data[19] = {`SET, 4'd0, 8'd11};            // SET R0, delay_loop
	assign rom_data[20] = {`SET, 4'd1, 8'd0};             // SET R1, 0
	assign rom_data[21] = {`ADD, 4'd0, 4'd15, 4'd1};      // ADD R0, R15, R1

	always @(*) begin
		if (addr > 8'd21)
			data = {`NOP, 12'b0};
		else
			data = rom_data[addr];
	end

endmodule
