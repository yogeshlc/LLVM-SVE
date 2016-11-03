// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVVM
// Restricted predicate has range [0, 7].
lsl z22.d, p8/m, z22.d, z22.d
// CHECK: error: invalid operand
