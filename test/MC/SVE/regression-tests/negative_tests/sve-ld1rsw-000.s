// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadDup4SIZ
// Restricted predicate has range [0, 7].
ld1rsw z23.d, p8/z, [x6, #48]
// CHECK: error: invalid operand
