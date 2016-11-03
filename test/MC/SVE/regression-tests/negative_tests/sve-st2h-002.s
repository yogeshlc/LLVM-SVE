// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Store2SIZ
// Restricted predicate has range [0, 7].
st2h {z23.h, z24.h}, p8, [x23, #2, MUL VL]
// CHECK: error: invalid operand
