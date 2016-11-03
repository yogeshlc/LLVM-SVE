// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load1VIZ
// Restricted predicate has range [0, 7].
ld1b z1.s, p8/z, [z10.s, #19]
// CHECK: error: invalid operand
