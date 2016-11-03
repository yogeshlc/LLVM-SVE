// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64_8FromDVM
// Restricted predicate has range [0, 7].
fcvtzs z29.d, p8/m, z20.d
// CHECK: error: invalid operand
