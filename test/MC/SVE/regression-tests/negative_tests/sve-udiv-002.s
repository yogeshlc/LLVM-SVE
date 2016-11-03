// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64DivVVM
// Restricted predicate has range [0, 7].
udiv z1.d, p8/m, z1.d, z0.d
// CHECK: error: invalid operand
