// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore4LSSZ
// Restricted predicate has range [0, 7].
st1w z3.d, p8, [x11, x1, lsl #2]
// CHECK: error: invalid operand
