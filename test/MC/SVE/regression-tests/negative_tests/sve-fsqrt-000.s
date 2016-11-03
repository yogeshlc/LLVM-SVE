// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SqrtVM
// Restricted predicate has range [0, 7].
fsqrt z1.d, p8/m, z29.d
// CHECK: error: invalid operand
