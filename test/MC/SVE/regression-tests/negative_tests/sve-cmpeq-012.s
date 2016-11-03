// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgEQVIZ
// Restricted predicate has range [0, 7].
cmpeq p1.d, p8/z, z30.d, #-16
// CHECK: error: invalid operand
