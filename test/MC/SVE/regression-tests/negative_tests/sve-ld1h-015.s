// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2XSVZ
// Restricted predicate has range [0, 7].
ld1h z30.s, p8/z, [x19, z17.s, sxtw #1]
// CHECK: error: invalid operand
