// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Load4SIZ
// Restricted predicate has range [0, 7].
ld2w {z8.s, z9.s}, p8/z, [x23, #11, MUL VL]
// CHECK: error: invalid operand
