// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubVVM
// Source and Destination Registers must match
fsub z15.d, p3/m, z16.d, z8.d
// CHECK: error: operand must match destination register
