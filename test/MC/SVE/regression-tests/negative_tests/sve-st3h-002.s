// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Store2SIZ
// Restricted predicate has range [0, 7].
st3h {z0.h, z1.h, z2.h}, p8, [x5, #10, MUL VL]
// CHECK: error: invalid operand
