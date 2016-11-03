// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Load1SIZ
// Restricted predicate has range [0, 7].
ld4b {z13.b, z14.b, z15.b, z16.b}, p8/z, [x6, #8, MUL VL]
// CHECK: error: invalid operand
