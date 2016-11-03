// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store4SVZ
// Restricted predicate has range [0, 7].
st1w z2.s, p8, [x0, z20.s, uxtw #2]
// CHECK: error: invalid operand
