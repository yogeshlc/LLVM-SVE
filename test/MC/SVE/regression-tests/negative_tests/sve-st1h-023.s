// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store2VIZ
// Restricted predicate has range [0, 7].
st1h z26.d, p8, [z5.d, #6]
// CHECK: error: invalid operand
