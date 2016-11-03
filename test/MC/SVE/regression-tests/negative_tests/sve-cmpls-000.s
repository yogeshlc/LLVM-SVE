// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmpls p0.h, p8/z, z21.h, #0
// CHECK: error: invalid operand
