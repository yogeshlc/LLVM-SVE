// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MaxVVM
// Source and Destination Registers must match
smax z3.s, p4/m, z4.s, z9.s
// CHECK: error: operand must match destination register
