// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Store2LSSZ
// Restricted predicate has range [0, 7].
st3h {z20.h, z21.h, z22.h}, p8, [x25, x13, lsl #1]
// CHECK: error: invalid operand
