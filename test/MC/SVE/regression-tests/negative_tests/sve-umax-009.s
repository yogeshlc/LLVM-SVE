// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MaxVVM
// Source and Destination Registers must match
umax z15.s, p3/m, z16.s, z2.s
// CHECK: error: operand must match destination register
