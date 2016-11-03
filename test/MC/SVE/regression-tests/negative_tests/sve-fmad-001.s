// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FMADDVVVM
// Restricted predicate has range [0, 7].
fmad z19.s, p8/m, z29.s, z23.s
// CHECK: error: invalid operand
