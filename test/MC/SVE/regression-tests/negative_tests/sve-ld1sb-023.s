// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load1VSZ
// Restricted predicate has range [0, 7].
ld1sb z9.d, p8/z, [x14, z2.d]
// CHECK: error: invalid operand
