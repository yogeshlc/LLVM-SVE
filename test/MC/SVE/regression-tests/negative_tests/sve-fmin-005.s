// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinVIM
// Source and Destination Registers must match
fmin z30.s, p1/m, z31.s, #0.0
// CHECK: error: operand must match destination register
