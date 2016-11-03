// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SubRVIX
// Source and Destination Registers must match
subr z19.s, z20.s, #0
// CHECK: error: operand must match destination register
