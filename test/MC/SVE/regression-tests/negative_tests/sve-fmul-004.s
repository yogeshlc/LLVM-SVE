// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MulVIM
// Restricted predicate has range [0, 7].
fmul z24.s, p8/m, z24.s, #0.5
// CHECK: error: invalid operand
