// RUN: llvm-mc -triple aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s

  .globl _func

// Check that the assembler can handle the documented syntax from the ARM ARM.
// For complex constructs like shifter operands, check more thoroughly for them
// once then spot check that following instructions accept the form generally.
// This gives us good coverage while keeping the overall size of the test
// more reasonable.


_func:
// CHECK: _func

	ldr z0,  [x0]
	ldr z4,  [x29, #0, mul vl]
	ldr z30, [x12, #64, mul vl]
	ldr z20, [sp, #8, mul vl]
	ldr z21, [x12, #8*8, mul vl]
	ldr z23, [x13, #(2+5+1)*8, mul vl]
// CHECK: ldr      z0,  [x0]                   // encoding: [0x00,0x40,0x80,0x85]
// CHECK: ldr      z4,  [x29]                  // encoding: [0xa4,0x43,0x80,0x85]
// CHECK: ldr      z30, [x12, #64, mul vl]     // encoding: [0x9e,0x41,0x88,0x85]
// CHECK: ldr      z20, [sp, #8, mul vl]       // encoding: [0xf4,0x43,0x81,0x85]
// CHECK: ldr      z21, [x12, #64, mul vl]     // encoding: [0x95,0x41,0x88,0x85]
// CHECK: ldr      z23, [x13, #64, mul vl]     // encoding: [0xb7,0x41,0x88,0x85]
	ldr p2,  [sp]
	ldr p7,  [sp, #-64, mul vl]
	ldr p13, [x2, #-4, mul vl]
// CHECK: ldr      p2,  [sp]                   // encoding: [0xe2,0x03,0x80,0x85]
// CHECK: ldr      p7,  [sp, #-64, mul vl]     // encoding: [0xe7,0x03,0xb8,0x85]
// CHECK: ldr      p13, [x2, #-4, mul vl]      // encoding: [0x4d,0x10,0xbf,0x85]
	.equ fred, 3
	.equ sally, -3

	ldr z15, [x5, fred, mul vl]
	ldr z3,  [x2, sally, mul vl]
// CHECK: ldr    z15, [x5, #3, mul vl]    // encoding: [0xaf,0x4c,0x80,0x85]
// CHECK: ldr    z3, [x2, #-3, mul vl]    // encoding: [0x43,0x54,0xbf,0x85]
	.equ bob, 10
	lsl z21.s, p5/m, z21.s, bob
// CHECK: lsl    z21.s, p5/m, z21.s, #10  // encoding: [0x55,0x95,0x43,0x04]
