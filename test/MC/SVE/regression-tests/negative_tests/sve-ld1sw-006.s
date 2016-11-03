// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4VIZ
// Restricted predicate has range [0, 7].
ld1sw z26.d, p8/z, [z10.d, #27]
// CHECK: error: invalid operand
