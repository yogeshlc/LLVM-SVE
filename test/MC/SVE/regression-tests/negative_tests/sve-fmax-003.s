// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxVVM
// Source and Destination Registers must match
fmax z26.d, p5/m, z27.d, z27.d
// CHECK: error: operand must match destination register
