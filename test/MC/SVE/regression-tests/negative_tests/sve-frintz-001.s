// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FRIntZVM
// Restricted predicate has range [0, 7].
frintz z10.s, p8/m, z6.s
// CHECK: error: invalid operand
