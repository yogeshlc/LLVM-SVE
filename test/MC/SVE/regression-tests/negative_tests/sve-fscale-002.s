// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32ScaleVVM
// Restricted predicate has range [0, 7].
fscale z26.s, p8/m, z26.s, z29.s
// CHECK: error: invalid operand
