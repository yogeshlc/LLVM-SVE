// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Load1SIZ
// Restricted predicate has range [0, 7].
ld2b {z9.b, z10.b}, p8/z, [x2, #11, MUL VL]
// CHECK: error: invalid operand
