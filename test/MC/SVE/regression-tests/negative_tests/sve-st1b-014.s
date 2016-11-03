// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store1XVSZ
// Restricted predicate has range [0, 7].
st1b z20.s, p8, [x14, z7.s, sxtw]
// CHECK: error: invalid operand
