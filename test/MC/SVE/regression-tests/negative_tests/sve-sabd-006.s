// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8AbdVVM
// Restricted predicate has range [0, 7].
sabd z12.b, p8/m, z12.b, z19.b
// CHECK: error: invalid operand
