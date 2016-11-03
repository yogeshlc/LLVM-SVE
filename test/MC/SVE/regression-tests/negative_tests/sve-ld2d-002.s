// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Load8SIZ
// Restricted predicate has range [0, 7].
ld2d {z7.d, z8.d}, p8/z, [x27, #3, MUL VL]
// CHECK: error: invalid operand
