// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store4XSVZ
// Restricted predicate has range [0, 7].
st1w z19.s, p8, [x22, z6.s, sxtw #2]
// CHECK: error: invalid operand
