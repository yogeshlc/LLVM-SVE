// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SubRVVM
// Restricted predicate has range [0, 7].
subr z3.s, p8/m, z3.s, z19.s
// CHECK: error: invalid operand
