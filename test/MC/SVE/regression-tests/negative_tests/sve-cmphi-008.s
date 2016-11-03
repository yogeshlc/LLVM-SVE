// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmphi p10.s, p8/z, z14.s, z22.s
// CHECK: error: invalid operand
