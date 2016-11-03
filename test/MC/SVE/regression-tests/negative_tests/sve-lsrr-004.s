// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrRVVM
// Restricted predicate has range [0, 7].
lsrr z18.d, p8/m, z18.d, z15.d
// CHECK: error: invalid operand
