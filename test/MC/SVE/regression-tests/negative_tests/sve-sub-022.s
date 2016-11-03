// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubVVM
// Restricted predicate has range [0, 7].
sub z7.d, p8/m, z7.d, z10.d
// CHECK: error: invalid operand
