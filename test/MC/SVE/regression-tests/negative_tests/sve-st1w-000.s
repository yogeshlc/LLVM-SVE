// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore4LSSZ
// Restricted predicate has range [0, 7].
st1w z10.s, p8, [x8, x23, lsl #2]
// CHECK: error: invalid operand
