// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxNumVVM
// Source and Destination Registers must match
fmaxnm z3.d, p0/m, z4.d, z17.d
// CHECK: error: operand must match destination register
