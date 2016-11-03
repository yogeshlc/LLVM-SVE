// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrRVVM
// Restricted predicate has range [0, 7].
asrr z8.d, p8/m, z8.d, z3.d
// CHECK: error: invalid operand
