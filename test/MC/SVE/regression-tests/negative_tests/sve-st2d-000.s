// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Store8LSSZ
// Restricted predicate has range [0, 7].
st2d {z2.d, z3.d}, p8, [x15, x26, lsl #3]
// CHECK: error: invalid operand
