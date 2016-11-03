// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubRVIM
// Source and Destination Registers must match
fsubr z3.d, p5/m, z4.d, #0.5
// CHECK: error: operand must match destination register
