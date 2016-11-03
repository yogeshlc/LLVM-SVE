// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4VSZ
// Restricted predicate has range [0, 7].
st1w z3.d, p8, [x13, z25.d]
// CHECK: error: invalid operand
