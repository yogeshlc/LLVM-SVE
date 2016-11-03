// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxNumVIM
// Source and Destination Registers must match
fmaxnm z29.s, p3/m, z30.s, #0.0
// CHECK: error: operand must match destination register
