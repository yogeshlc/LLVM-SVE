// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MaxVVM
// Source and Destination Registers must match
umax z27.d, p1/m, z28.d, z18.d
// CHECK: error: operand must match destination register
