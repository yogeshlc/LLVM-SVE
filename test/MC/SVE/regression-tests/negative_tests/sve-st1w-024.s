// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4YSVZ
// Restricted predicate has range [0, 7].
st1w z15.d, p8, [x23, z3.d, uxtw #2]
// CHECK: error: invalid operand
