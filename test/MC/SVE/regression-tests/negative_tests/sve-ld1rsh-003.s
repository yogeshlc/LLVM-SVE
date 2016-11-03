// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadDup2SIZ
// Restricted predicate has range [0, 7].
ld1rsh z2.d, p8/z, [x5, #44]
// CHECK: error: invalid operand
