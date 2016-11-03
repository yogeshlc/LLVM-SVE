// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmphi p11.s, p8/z, z30.s, #0
// CHECK: error: invalid operand
