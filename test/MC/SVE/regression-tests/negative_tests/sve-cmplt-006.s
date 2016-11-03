// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplt p1.s, p8/z, z5.s, #-16
// CHECK: error: invalid operand
