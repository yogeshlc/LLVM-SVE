// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rsb z10.h, p8/z, [x11, #14]
// CHECK: error: invalid operand
