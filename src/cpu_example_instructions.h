`define NOP   4'd0  // 0 filled
`define LOAD  4'd1  // dest, op1, offset  : R[dest] = M[R[op1] + offset]
`define STORE 4'd2  // src, op1, offset   : M[R[op1] + offset] = R[src]
`define SET   4'd3  // dest, const        : R[dest] = const
`define LT    4'd4  // dest, op1, op2     : R[dest] = R[op1] < R[op2]
`define EQ    4'd5  // dest, op1, op2     : R[dest] = R[op1] == R[op2]
`define BEQ   4'd6  // op1, const         : R[0] = R[0] + (R[op1] == const ? 2 : 1)
`define BNEQ  4'd7  // op1, const         : R[0] = R[0] + (R[op1] != const ? 2 : 1)
`define ADD   4'd8  // dest, op1, op2     : R[dest] = R[op1] + R[op2]
`define SUB   4'd9  // dest, op1, op2     : R[dest] = R[op1] - R[op2]
`define SHL   4'd10 // dest, op1, op2     : R[dest] = R[op1] << R[op2]
`define SHR   4'd11 // dest, op1, op2     : R[dest] = R[op1] >> R[op2]
`define AND   4'd12 // dest, op1, op2     : R[dest] = R[op1] & R[op2]
`define OR    4'd13 // dest, op1, op2     : R[dest] = R[op1] | R[op2]
`define INV   4'd14 // dest, op1          : R[dest] = ~R[op1]
`define XOR   4'd15 // dest, op1, op2     : R[dest] = R[op1] ^ R[op2]