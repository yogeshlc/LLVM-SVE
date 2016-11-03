// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4VIZ
// Restricted predicate has range [0, 7].
st1w z8.d, p8, [z27.d, #27]
// CHECK: error: invalid operand
