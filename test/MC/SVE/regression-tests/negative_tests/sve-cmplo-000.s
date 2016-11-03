// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplo p6.h, p8/z, z14.h, #0
// CHECK: error: invalid operand
