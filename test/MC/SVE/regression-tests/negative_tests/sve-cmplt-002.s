// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplt p4.h, p8/z, z6.h, #-16
// CHECK: error: invalid operand
