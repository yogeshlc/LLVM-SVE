// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Load2SIZ
// Restricted predicate has range [0, 7].
ld3h {z20.h, z21.h, z22.h}, p8/z, [x16, #13, MUL VL]
// CHECK: error: invalid operand
