// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVWM
// Restricted predicate has range [0, 7].
lsl z3.b, p8/m, z3.b, z1.d
// CHECK: error: invalid operand
