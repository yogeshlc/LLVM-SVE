// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubRVIX
// Source and Destination Registers must match
subr z16.d, z17.d, #0
// CHECK: error: operand must match destination register
