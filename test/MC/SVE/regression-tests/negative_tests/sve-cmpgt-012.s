// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmpgt p5.d, p8/z, z23.d, #-16
// CHECK: error: invalid operand
