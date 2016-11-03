// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Store2LSSZ
// Restricted predicate has range [0, 7].
st4h {z20.h, z21.h, z22.h, z23.h}, p8, [x8, x5, lsl #1]
// CHECK: error: invalid operand
