// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FMSUBVVVM
// Restricted predicate has range [0, 7].
fmsb z15.s, p8/m, z26.s, z22.s
// CHECK: error: invalid operand
