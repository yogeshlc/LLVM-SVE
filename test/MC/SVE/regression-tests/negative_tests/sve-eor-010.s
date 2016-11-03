// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64XorVVM
// Restricted predicate has range [0, 7].
eor z13.d, p8/m, z13.d, z7.d
// CHECK: error: invalid operand
