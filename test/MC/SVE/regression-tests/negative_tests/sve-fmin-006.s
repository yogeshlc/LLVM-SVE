// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinVVM
// Restricted predicate has range [0, 7].
fmin z23.s, p8/m, z23.s, z1.s
// CHECK: error: invalid operand
