// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4XSVZ
// Restricted predicate has range [0, 7].
st1w z23.d, p8, [x17, z1.d, sxtw #2]
// CHECK: error: invalid operand
