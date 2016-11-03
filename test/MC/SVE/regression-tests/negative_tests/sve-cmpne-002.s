// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgNEVIZ
// Restricted predicate has range [0, 7].
cmpne p9.h, p8/z, z15.h, #-16
// CHECK: error: invalid operand
