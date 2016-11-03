// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmpge p5.d, p8/z, z9.d, #-16
// CHECK: error: invalid operand
