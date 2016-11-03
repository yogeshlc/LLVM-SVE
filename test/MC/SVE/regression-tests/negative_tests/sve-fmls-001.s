// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FMSVVVM
// Restricted predicate has range [0, 7].
fmls z8.s, p8/m, z1.s, z28.s
// CHECK: error: invalid operand
