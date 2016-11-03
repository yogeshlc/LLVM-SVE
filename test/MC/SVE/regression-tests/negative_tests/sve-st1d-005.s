// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8SVZ
// Restricted predicate has range [0, 7].
st1d z6.d, p8, [x10, z16.d, lsl #3]
// CHECK: error: invalid operand
