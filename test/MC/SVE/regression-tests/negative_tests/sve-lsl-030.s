// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVIM
// Restricted predicate has range [0, 7].
lsl z21.b, p8/m, z21.b, #0
// CHECK: error: invalid operand
