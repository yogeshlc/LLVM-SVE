// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVVM
// Restricted predicate has range [0, 7].
lsl z11.b, p8/m, z11.b, z14.b
// CHECK: error: invalid operand
