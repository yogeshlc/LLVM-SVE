// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmphi p12.h, p8/z, z2.h, z3.h
// CHECK: error: invalid operand
