// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplo p14.s, p8/z, z2.s, z7.d
// CHECK: error: invalid operand
