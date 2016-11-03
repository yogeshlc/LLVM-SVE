// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVVM
// Restricted predicate has range [0, 7].
lsl z30.s, p8/m, z30.s, z6.s
// CHECK: error: invalid operand
