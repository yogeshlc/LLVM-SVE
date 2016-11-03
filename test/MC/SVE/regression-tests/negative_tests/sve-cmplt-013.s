// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplt p6.b, p8/z, z9.b, #-16
// CHECK: error: invalid operand
