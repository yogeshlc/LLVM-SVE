// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmpls p0.d, p8/z, z14.d, #0
// CHECK: error: invalid operand
