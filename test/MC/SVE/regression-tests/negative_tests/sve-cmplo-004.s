// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplo p10.s, p8/z, z8.s, #0
// CHECK: error: invalid operand
