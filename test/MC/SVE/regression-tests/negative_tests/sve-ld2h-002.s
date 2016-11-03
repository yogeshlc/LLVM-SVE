// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Load2SIZ
// Restricted predicate has range [0, 7].
ld2h {z26.h, z27.h}, p8/z, [x11, #0, MUL VL]
// CHECK: error: invalid operand
