// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8InvVM
// Restricted predicate has range [0, 7].
not z22.b, p8/m, z3.b
// CHECK: error: invalid operand
