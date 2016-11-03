// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubVIM
// Source and Destination Registers must match
fsub z16.d, p5/m, z17.d, #0.5
// CHECK: error: operand must match destination register
