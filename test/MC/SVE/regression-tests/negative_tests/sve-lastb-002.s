// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32LastBV
// Restricted predicate has range [0, 7].
lastb s0, p8, z14.s
// CHECK: error: invalid operand
