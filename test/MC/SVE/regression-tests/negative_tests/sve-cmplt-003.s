// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplt p13.h, p8/z, z8.h, z10.d
// CHECK: error: invalid operand
