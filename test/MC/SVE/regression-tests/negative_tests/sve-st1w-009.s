// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store4VSZ
// Restricted predicate has range [0, 7].
st1w z17.s, p8, [x7, z4.s, uxtw]
// CHECK: error: invalid operand
