// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MinVVM
// Source and Destination Registers must match
smin z26.s, p0/m, z27.s, z18.s
// CHECK: error: operand must match destination register
