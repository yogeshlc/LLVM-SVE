// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2VSZ
// Restricted predicate has range [0, 7].
ld1sh z2.d, p8/z, [x25, z0.d]
// CHECK: error: invalid operand
