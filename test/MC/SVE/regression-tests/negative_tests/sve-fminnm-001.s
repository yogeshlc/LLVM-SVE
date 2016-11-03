// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinNumVIM
// Source and Destination Registers must match
fminnm z20.d, p3/m, z21.d, #0.0
// CHECK: error: operand must match destination register
