// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store2XVSZ
// Restricted predicate has range [0, 7].
st1h z26.s, p8, [x16, z2.s, sxtw]
// CHECK: error: invalid operand
