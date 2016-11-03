// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store4VIZ
// Restricted predicate has range [0, 7].
st1w z16.s, p8, [z24.s, #26]
// CHECK: error: invalid operand
