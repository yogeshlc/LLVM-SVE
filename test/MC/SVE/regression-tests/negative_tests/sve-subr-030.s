// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SubRVVM
// Restricted predicate has range [0, 7].
subr z21.b, p8/m, z21.b, z8.b
// CHECK: error: invalid operand
