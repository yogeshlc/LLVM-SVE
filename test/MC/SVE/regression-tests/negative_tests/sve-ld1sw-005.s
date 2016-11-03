// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4SVZ
// Restricted predicate has range [0, 7].
ld1sw z9.d, p8/z, [x20, z20.d, lsl #2]
// CHECK: error: invalid operand
