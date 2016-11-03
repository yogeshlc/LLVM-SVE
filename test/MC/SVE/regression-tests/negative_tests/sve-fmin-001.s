// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinVIM
// Source and Destination Registers must match
fmin z1.d, p2/m, z2.d, #0.0
// CHECK: error: operand must match destination register
