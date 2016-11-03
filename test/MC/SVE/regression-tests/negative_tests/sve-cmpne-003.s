// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgNEVVZ
// Restricted predicate has range [0, 7].
cmpne p0.h, p8/z, z21.h, z17.h
// CHECK: error: invalid operand
