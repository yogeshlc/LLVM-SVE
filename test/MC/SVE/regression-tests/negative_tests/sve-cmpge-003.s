// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmpge p4.h, p8/z, z18.h, z10.h
// CHECK: error: invalid operand
