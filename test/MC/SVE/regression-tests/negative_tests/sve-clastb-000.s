// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecB8CondXBSV
// Restricted predicate has range [0, 7].
clastb b23, p8, b23, z29.b
// CHECK: error: invalid operand
