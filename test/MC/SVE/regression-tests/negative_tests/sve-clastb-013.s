// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CondXBSV
// Source and Destination Registers must match
clastb w13, p5, w14, z3.s
// CHECK: error: operand must match destination register
