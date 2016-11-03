// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinVIM
// Restricted predicate has range [0, 7].
fmin z4.s, p8/m, z4.s, #0.0
// CHECK: error: invalid operand
