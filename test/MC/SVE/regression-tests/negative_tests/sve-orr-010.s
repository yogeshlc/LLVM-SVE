// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64OrVVM
// Restricted predicate has range [0, 7].
orr z23.d, p8/m, z23.d, z8.d
// CHECK: error: invalid operand
