// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVWM
// Restricted predicate has range [0, 7].
lsl z2.h, p8/m, z2.h, z5.d
// CHECK: error: invalid operand
