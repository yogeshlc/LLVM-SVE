// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgNEVWZ
// Restricted predicate has range [0, 7].
cmpne p6.h, p8/z, z14.h, z22.d
// CHECK: error: invalid operand
