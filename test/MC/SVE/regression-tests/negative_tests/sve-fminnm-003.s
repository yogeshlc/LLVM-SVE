// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinNumVVM
// Source and Destination Registers must match
fminnm z17.d, p6/m, z18.d, z25.d
// CHECK: error: operand must match destination register
