// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rb z2.h, p8/z, [x18, #19]
// CHECK: error: invalid operand
