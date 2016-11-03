// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store4XVSZ
// Restricted predicate has range [0, 7].
st1w z27.s, p8, [x21, z26.s, sxtw]
// CHECK: error: invalid operand
