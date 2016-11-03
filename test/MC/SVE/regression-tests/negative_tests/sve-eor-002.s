// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32XorVVM
// Restricted predicate has range [0, 7].
eor z6.s, p8/m, z6.s, z20.s
// CHECK: error: invalid operand
