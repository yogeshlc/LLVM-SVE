// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CondXBSV
// Restricted predicate has range [0, 7].
clastb x21, p8, x21, z2.d
// CHECK: error: invalid operand
