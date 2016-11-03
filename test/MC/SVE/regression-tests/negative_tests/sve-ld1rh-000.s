// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LoadDup2SIZ
// Restricted predicate has range [0, 7].
ld1rh z7.h, p8/z, [x17, #19]
// CHECK: error: invalid operand
