// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmphi p13.s, p8/z, z8.s, z0.d
// CHECK: error: invalid operand
