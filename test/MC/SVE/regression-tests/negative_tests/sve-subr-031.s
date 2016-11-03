// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SubRVVM
// Source and Destination Registers must match
subr z28.b, p4/m, z29.b, z26.b
// CHECK: error: operand must match destination register
