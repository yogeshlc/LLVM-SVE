// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVIM
// Restricted predicate has range [0, 7].
lsl z13.s, p8/m, z13.s, #0
// CHECK: error: invalid operand
