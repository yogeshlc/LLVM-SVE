// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CondXBSV
// Restricted predicate has range [0, 7].
clastb w18, p8, w18, z5.s
// CHECK: error: invalid operand
