// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CondXBSV
// Restricted predicate has range [0, 7].
clastb w16, p8, w16, z5.b
// CHECK: error: invalid operand
