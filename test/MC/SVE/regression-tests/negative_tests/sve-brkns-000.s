// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecPBreakNextFlgPZ
// Source and Destination Registers must match
brkns p10.b, p6/z, p9.b, p11.b
// CHECK: error: operand must match destination register
