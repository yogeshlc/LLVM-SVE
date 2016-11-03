// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubRVVM
// Restricted predicate has range [0, 7].
subr z17.d, p8/m, z17.d, z29.d
// CHECK: error: invalid operand
