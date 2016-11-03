// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FRIntAVM
// Restricted predicate has range [0, 7].
frinta z27.s, p8/m, z21.s
// CHECK: error: invalid operand
