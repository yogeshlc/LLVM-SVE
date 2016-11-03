// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinVVM
// Source and Destination Registers must match
fmin z26.d, p3/m, z27.d, z26.d
// CHECK: error: operand must match destination register
