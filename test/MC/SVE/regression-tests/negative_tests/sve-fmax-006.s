// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxVVM
// Restricted predicate has range [0, 7].
fmax z30.s, p8/m, z30.s, z21.s
// CHECK: error: invalid operand
