// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rsb z28.s, p8/z, [x10, #11]
// CHECK: error: invalid operand
