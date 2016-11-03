// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgLEVWZ
// Restricted predicate has range [0, 7].
cmpls p14.h, p8/z, z3.h, z9.d
// CHECK: error: invalid operand
