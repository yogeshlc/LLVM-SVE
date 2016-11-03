// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64_4FromDVM
// Restricted predicate has range [0, 7].
fcvtzs z29.s, p8/m, z9.d
// CHECK: error: invalid operand
