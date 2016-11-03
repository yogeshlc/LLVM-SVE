// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store2XVSZ
// Restricted predicate has range [0, 7].
st1h z2.d, p8, [x4, z16.d, sxtw]
// CHECK: error: invalid operand
