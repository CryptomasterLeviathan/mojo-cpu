//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:13 01/24/2018 
// Design Name: 
// Module Name:    cpu_example 
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

module cpu_example(
		input clk,
		input rst,
		output [7:0] addr,
		output read,
		input [7:0] din,
		output write,
		output [7:0] dout
	);

	// Registers for CPU output
	reg read;
	reg write;
	reg [7:0] dout;
	reg [7:0] addr;

	// Index for loops
	integer i;

	// CPU registers
	reg [7:0] reg_d [15:0];
	reg [7:0] reg_q [15:0];

	// Wires used to decode and perform instructions
	wire [15:0] inst;
	reg [3:0] op;
	reg [3:0] dest;
	reg [3:0] arg1;
	reg [3:0] arg2;
	reg [7:0] const;

	cpu_example_rom rom (
		.clk(clk),
		.addr(reg_q[0]),
		.data(inst)
	);

	always @(posedge clk) begin
		// TODO: These might be able to be changed to wires
		// Split the instruction into parts
		op = inst[15:12];
		dest = inst[11:8];
		arg1 = inst[7:4];
		arg2 = inst[3:0];
		const = {arg1, arg2};

		// Set default values
		read = 1'b0;
		write = 1'b0;
		dout = 8'hxx;
		addr = 8'hxx;
		
		// Increment the instruction counter
		reg_d[0] = reg_q[0] + 8'd1;
		// Set default value to create flip flops instead of latches
		for (i=1; i<16; i=i+1) begin
			reg_d[i] = reg_q[i];
		end

		// Handle the instructions
		case (op)
			`LOAD: begin
				read = 1'b1;
				addr = reg_q[arg1] + arg2;
				reg_d[dest] = din;
			end
			`STORE: begin
				write = 1'b1;
				addr = reg_q[arg1] + arg2;
				dout = reg_q[dest];
			end
			`SET: begin
				reg_d[dest] = const;
			end
			`LT: begin
				reg_d[dest] = reg_q[arg1] < reg_q[arg2];
			end
			`EQ: begin
				reg_d[dest] = reg_q[arg1] == reg_q[arg2];
			end
			`BEQ: begin
				if (reg_q[dest] == const)
					reg_d[0] = reg_q[0] + 8'd2;
			end
			`BNEQ: begin
				if (reg_q[dest] != const)
					reg_d[0] = reg_q[0] + 8'd2;
			end
			`ADD: begin
				reg_d[dest] = reg_q[arg1] + reg_q[arg2];
			end
			`SUB: begin
				reg_d[dest] = reg_q[arg1] + reg_q[arg2];
			end
			`SHL: begin
				reg_d[dest] = reg_q[arg1] << reg_q[arg2];
			end
			`SHR: begin
				reg_d[dest] = reg_q[arg1] >> reg_q[arg2];
			end
			`AND: begin
				reg_d[dest] = reg_q[arg1] & reg_q[arg2];
			end
			`OR: begin
				reg_d[dest] = reg_q[arg1] | reg_q[arg2];
			end
			`INV: begin
				reg_d[dest] = ~reg_q[arg1];
			end
			`XOR: begin
				reg_d[dest] = reg_q[arg1] ^ reg_q[arg2];
			end
		endcase

		// Handle the flippy-floppies
		//for (i=0; i<16; i=i+1) begin
		//	reg_q[i] <= reg_d[i];
		//end
	end
	
	always @(posedge clk) begin
		// Handle the flippy-floppies
		for (i=0; i<16; i=i+1) begin
			reg_q[i] <= reg_d[i];
		end
	end

endmodule
