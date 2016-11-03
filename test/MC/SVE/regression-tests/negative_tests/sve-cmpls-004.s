// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmpls p5.s, p8/z, z10.s, #0
// CHECK: error: invalid operand
