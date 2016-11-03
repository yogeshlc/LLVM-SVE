// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AbdVVM
// Source and Destination Registers must match
fabd z18.d, p3/m, z19.d, z23.d
// CHECK: error: operand must match destination register
