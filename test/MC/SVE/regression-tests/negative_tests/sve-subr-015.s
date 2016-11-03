// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SubRVVM
// Source and Destination Registers must match
subr z10.s, p4/m, z11.s, z8.s
// CHECK: error: operand must match destination register
