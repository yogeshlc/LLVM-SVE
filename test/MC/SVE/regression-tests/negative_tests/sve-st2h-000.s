// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Store2LSSZ
// Restricted predicate has range [0, 7].
st2h {z28.h, z29.h}, p8, [x6, x27, lsl #1]
// CHECK: error: invalid operand
