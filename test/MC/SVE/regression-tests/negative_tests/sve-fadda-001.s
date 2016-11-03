// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddReduceAV
// Source and Destination Registers must match
fadda d27, p1, d28, z21.d
// CHECK: error: operand must match destination register
