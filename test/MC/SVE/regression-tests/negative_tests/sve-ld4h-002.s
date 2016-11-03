// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Load2SIZ
// Restricted predicate has range [0, 7].
ld4h {z28.h, z29.h, z30.h, z31.h}, p8/z, [x20, #11, MUL VL]
// CHECK: error: invalid operand
