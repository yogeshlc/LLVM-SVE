// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVWM
// Restricted predicate has range [0, 7].
lsl z20.s, p8/m, z20.s, z7.d
// CHECK: error: invalid operand
