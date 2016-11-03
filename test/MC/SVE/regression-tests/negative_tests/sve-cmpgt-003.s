// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmpgt p10.h, p8/z, z8.h, z21.h
// CHECK: error: invalid operand
