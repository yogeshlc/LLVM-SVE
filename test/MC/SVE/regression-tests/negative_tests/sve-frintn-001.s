// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FRIntNVM
// Restricted predicate has range [0, 7].
frintn z21.s, p8/m, z3.s
// CHECK: error: invalid operand
