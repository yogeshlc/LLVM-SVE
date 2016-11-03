// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVIM
// Restricted predicate has range [0, 7].
lsl z2.d, p8/m, z2.d, #0
// CHECK: error: invalid operand
