// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CondXBSV
// Restricted predicate has range [0, 7].
clastb d17, p8, d17, z23.d
// CHECK: error: invalid operand
