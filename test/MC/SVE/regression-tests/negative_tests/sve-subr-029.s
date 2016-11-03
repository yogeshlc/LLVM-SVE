// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SubRVIX
// Source and Destination Registers must match
subr z25.b, z26.b, #0
// CHECK: error: operand must match destination register
