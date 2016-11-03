// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecPBreakNextPZ
// Source and Destination Registers must match
brkn p4.b, p11/z, p7.b, p5.b
// CHECK: error: operand must match destination register
