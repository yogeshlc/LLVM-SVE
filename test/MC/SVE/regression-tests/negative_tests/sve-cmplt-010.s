// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplt p6.d, p8/z, z14.d, #-16
// CHECK: error: invalid operand
