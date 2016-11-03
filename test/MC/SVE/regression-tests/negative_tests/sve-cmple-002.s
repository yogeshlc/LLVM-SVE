// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmple p6.h, p8/z, z16.h, #-16
// CHECK: error: invalid operand
