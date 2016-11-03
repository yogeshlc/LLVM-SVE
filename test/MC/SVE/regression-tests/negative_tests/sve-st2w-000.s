// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Store4LSSZ
// Restricted predicate has range [0, 7].
st2w {z16.s, z17.s}, p8, [x5, x22, lsl #2]
// CHECK: error: invalid operand
