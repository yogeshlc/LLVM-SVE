// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Store4LSSZ
// Restricted predicate has range [0, 7].
st4w {z4.s, z5.s, z6.s, z7.s}, p8, [x21, x28, lsl #2]
// CHECK: error: invalid operand
