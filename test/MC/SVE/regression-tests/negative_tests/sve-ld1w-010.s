// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load4XSVZ
// Restricted predicate has range [0, 7].
ld1w z21.s, p8/z, [x13, z29.s, sxtw #2]
// CHECK: error: invalid operand
