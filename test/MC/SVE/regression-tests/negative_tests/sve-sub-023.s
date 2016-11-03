// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubVVM
// Source and Destination Registers must match
sub z27.d, p3/m, z28.d, z28.d
// CHECK: error: operand must match destination register
