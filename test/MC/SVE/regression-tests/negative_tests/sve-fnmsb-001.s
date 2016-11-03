// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FNMSUBVVVM
// Restricted predicate has range [0, 7].
fnmsb z9.s, p8/m, z1.s, z8.s
// CHECK: error: invalid operand
