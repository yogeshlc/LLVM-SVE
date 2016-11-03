// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32_4FromFVM
// Restricted predicate has range [0, 7].
fcvtzs z6.s, p8/m, z2.s
// CHECK: error: invalid operand
