// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubRVVM
// Source and Destination Registers must match
subr z9.d, p1/m, z10.d, z18.d
// CHECK: error: operand must match destination register
