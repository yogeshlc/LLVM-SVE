// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64_8FromFVM
// Restricted predicate has range [0, 7].
fcvtzs z8.d, p8/m, z17.s
// CHECK: error: invalid operand
