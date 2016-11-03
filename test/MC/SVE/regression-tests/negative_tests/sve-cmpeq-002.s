// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgEQVIZ
// Restricted predicate has range [0, 7].
cmpeq p13.h, p8/z, z18.h, #-16
// CHECK: error: invalid operand
