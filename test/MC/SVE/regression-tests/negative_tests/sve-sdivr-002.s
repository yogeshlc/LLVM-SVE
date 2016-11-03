// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64DivRVVM
// Restricted predicate has range [0, 7].
sdivr z28.d, p8/m, z28.d, z15.d
// CHECK: error: invalid operand
