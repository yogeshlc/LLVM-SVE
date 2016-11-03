// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4VSZ
// Restricted predicate has range [0, 7].
ld1sw z12.d, p8/z, [x2, z6.d]
// CHECK: error: invalid operand
