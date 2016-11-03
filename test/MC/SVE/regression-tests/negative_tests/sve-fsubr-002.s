// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubRVVM
// Restricted predicate has range [0, 7].
fsubr z9.d, p8/m, z9.d, z27.d
// CHECK: error: invalid operand
