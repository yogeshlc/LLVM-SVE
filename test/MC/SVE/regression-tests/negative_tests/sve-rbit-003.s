// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8RBitVM
// Restricted predicate has range [0, 7].
rbit z11.b, p8/m, z3.b
// CHECK: error: invalid operand
