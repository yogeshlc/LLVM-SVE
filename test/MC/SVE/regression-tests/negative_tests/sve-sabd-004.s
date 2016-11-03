// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64AbdVVM
// Restricted predicate has range [0, 7].
sabd z23.d, p8/m, z23.d, z20.d
// CHECK: error: invalid operand
