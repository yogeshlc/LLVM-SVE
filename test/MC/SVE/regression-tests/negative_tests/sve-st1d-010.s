// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8XSVZ
// Restricted predicate has range [0, 7].
st1d z2.d, p8, [x13, z16.d, sxtw #3]
// CHECK: error: invalid operand
